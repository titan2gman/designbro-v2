import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'
import classNames from 'classnames'
import Dinero from 'dinero.js'

//styles
import styles from './DetailsStep.module.scss'

//components
import Spinner from '../../components/Spinner'
import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import RequestCallModal from '../../components/RequestCallModal'
import SummaryItem from '../../components/Summary/SummaryItem'
import SavingsAmount from '../../components/Summary/SavingsAmount'
import { TopDesigners } from './components/Features/TopDesigners'
import { BlindProject } from './components/Features/BlindProject'
import { NDA } from './components/Features/NDA'
import { BrandIdentity } from './components/Features/BrandIdentity'
import { DesignersNumber } from './components/Features/DesignersNumber'
import { Total } from '../../components/Summary/Total'
import { MoneyBackGuarantee } from '../../components/Summary/MoneyBackGuarantee'
import { PaymentMethod } from '../../components/Summary/PaymentMethod'
import { Testimonial } from '../../components/Summary/Testimonial'
import Discount from '../../components/Discount'
import StandartNdaModal from '../DetailsOld/components/Features/StandardNdaModal'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'
import { loadProducts } from '../../actions/products'
import { loadNdaPrices } from '../../actions/ndaPrices'
import { loadDiscount } from '../../actions/discounts'

import { projectSelector } from '@selectors/newProjectBuilder'
import { ndaPricesLoadInProgressSelector, ndaPriceSelector } from '../../selectors/ndaPrices'
import { productSelector, productByKeySelector, productsLoadInProgressSelector, additionalDesignPriceSelector } from '../../selectors/products'
import { discountAmountSelector } from '../../selectors/discount'
import { isAuthenticatedSelector } from '@selectors/me'

import { blindProjectPrice, topDesignersPrice } from '@constants/prices'

import { showSignUpModal } from '@actions/modal'

const PackagePanel = ({ active, popular, name, price, children }) => {
  return (
    <div className={classNames(styles.packagePanel, { [styles.active]: active })}>
      {popular && <div className={styles.popular}>Popular</div>}
      <div className={styles.packageHeaderWrapper}>
        <div className={styles.packageHeader}>
          <div className={styles.packageName}>{name}</div>
          <div className={styles.packagePrice}>{price}</div>
        </div>
      </div>
      <div className={styles.packageContent}>
        {children}
      </div>
    </div>
  )
}

const Button = ({ children, onClick, selected, className }) => {
  return (
    <button
      className={classNames(className, styles.button, { [styles.selected]: selected })}
      onClick={onClick}
      type="button"
    >
      {children}
    </button>
  )
}

function getWindowDimensions() {
  const { innerWidth: width, innerHeight: height } = window
  return {
    width,
    height
  }
}

const Details = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [maxSpotsCount, setMaxSpotsCount] = useState(project.maxSpotsCount)

  useEffect(() => {
    dispatch(loadProducts())
    dispatch(loadNdaPrices())
  }, [])

  const ndaPricesLoadInProgress = useSelector(ndaPricesLoadInProgressSelector)
  const productsLoadInProgress = useSelector(productsLoadInProgressSelector)

  const inProgress = ndaPricesLoadInProgress || productsLoadInProgress

  const isAuthenticated = useSelector(isAuthenticatedSelector)

  const product = useSelector(productSelector)
  const brandIdentityProduct = useSelector((state) => productByKeySelector(state, 'brand-identity'))
  const brandIdentityProductPrice = _.get(brandIdentityProduct, ['price', 'cents'], 0)


  const [maxScreensCount, setMaxScreensCount] = useState(project.maxScreensCount)
  const [ndaType, setNdaType] = useState(project.ndaType)
  const [upgradePackage, setUpgradePackage] = useState(project.upgradePackage)
  const [discountCode, setDiscountCode] = useState(project.discountCode || '')

  const [windowDimensions, setWindowDimensions] = useState(getWindowDimensions())

  const additionalDesignPrice = useSelector((state) => additionalDesignPriceSelector(state, maxSpotsCount))
  const starterAdditionalDesignPrice = 0
  const businessAdditionalDesignPrice = useSelector((state) => additionalDesignPriceSelector(state, 5))
  const proAdditionalDesignPrice = useSelector((state) => additionalDesignPriceSelector(state, 10))

  const ndaPrice = useSelector((state) => ndaPriceSelector(state, ndaType))
  const standardNdaPrice = useSelector((state) => ndaPriceSelector(state, 'standard'))

  const getProject = (newValues) => {
    return {
      maxSpotsCount,
      maxScreensCount,
      ndaType,
      upgradePackage,
      discountCode,
      ...newValues
    }
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleMaxSpotsCountChange = (value) => {
    setMaxSpotsCount(value)
    dispatch(updateProject(projectId, getProject({ maxSpotsCount: value }), step))
  }

  const handleNdaChange = () => {
    const value = ndaType === 'standard' ? 'free' : 'standard'
    setNdaType(value)
    dispatch(updateProject(projectId, getProject({ ndaType: value }), step))
  }

  const handleBrandIdentityChange = () => {
    setUpgradePackage(!upgradePackage)
    dispatch(updateProject(projectId, getProject({ upgradePackage: !upgradePackage }), step))
  }

  const handleDiscountCodeChange = (event) => {
    setDiscountCode(event.target.value)
    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
    dispatch(loadDiscount(event.target.value))
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    if (isAuthenticated) {
      dispatch(submitUpdateProject(projectId, getProject(), step, true))
    } else {
      dispatch(showSignUpModal({
        successCallback: signUpSuccessCallback
      }))
    }
  }

  const signUpSuccessCallback = () => {
    dispatch(submitUpdateProject(projectId, getProject(), step, true))
  }

  const additionalDesignPriceValue = Dinero({ amount: additionalDesignPrice })
  const ndaPriceValue = Dinero({ amount: ndaPrice })

  const brandIdentityUpgradePrice = Dinero({ amount: brandIdentityProductPrice - product.price.cents })
  let totalPrice = Dinero({ amount: (product.price.cents + ndaPrice ) }).add(additionalDesignPriceValue)

  if (upgradePackage) {
    totalPrice = totalPrice.add(brandIdentityUpgradePrice)
  }

  const discountAmount = useSelector((state) => discountAmountSelector(state, totalPrice))

  totalPrice = totalPrice.subtract(discountAmount)

  const starterPrice = product.price.cents + starterAdditionalDesignPrice
  const businessPrice = product.price.cents + businessAdditionalDesignPrice
  const proPrice = product.price.cents + proAdditionalDesignPrice

  return inProgress ? (<Spinner />) : (
    <>
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.header}>
          <Headline className={styles.headline}>Which design pack would you like?</Headline>
          <h2 className={styles.subheadline}>

            <span className={styles.total}>Total:</span>
            <span className={styles.price}>{totalPrice.toFormat('$0,0.00')}</span>
            <ContinueButton className={styles.headlineContinue} isValid={true}>Checkout →</ContinueButton>
          </h2>
        </div>

        <div className={styles.contentWrapper}>
          <div className={styles.content}>
            <PackagePanel
              active={maxSpotsCount === 3}
              name="Starter"
              price={Dinero({ amount: starterPrice }).toFormat('$0,0')}
            >
              <ul className={styles.features}>
                <li className={styles.feature}><strong>Expect 3 - 7 designs</strong></li>
                <li className={styles.feature}>From 3+ professional designers</li>
                <li className={styles.feature}>Unlimited revisions</li>
                <li className={styles.feature}>Full copyright</li>
                <li className={styles.feature}>Money back guarantee*</li>
              </ul>
              <div className={styles.buttonWrapper}>
                <Button onClick={() => { setMaxSpotsCount(3) }} selected={maxSpotsCount === 3}>{maxSpotsCount === 3 ? 'Selected' : 'Select'}</Button>
              </div>
            </PackagePanel>

            <PackagePanel
              popular
              active={maxSpotsCount === 5}
              name="Business"
              price={Dinero({ amount: businessPrice }).toFormat('$0,0')}
            >
              <ul className={styles.features}>
                <li className={styles.feature}><strong>Expect 5 - 9 designs</strong></li>
                <li className={styles.feature}>From 5+ professional designers</li>
                <li className={styles.feature}>Larger designer prize</li>
                <li className={styles.feature}>Unlimited revisions</li>
                <li className={styles.feature}>Full copyright</li>
                <li className={styles.feature}>Money back guarantee*</li>
              </ul>
              <div className={styles.buttonWrapper}>
                <Button onClick={() => { setMaxSpotsCount(5) }} selected={maxSpotsCount === 5}>{maxSpotsCount === 5 ? 'Selected' : 'Select'}</Button>
              </div>
            </PackagePanel>

            <PackagePanel
              active={maxSpotsCount === 10}
              name="Pro"
              price={Dinero({ amount: proPrice }).toFormat('$0,0')}
            >
              <ul className={styles.features}>
                <li className={styles.feature}><strong>Expect 10 - 15 designs</strong></li>
                <li className={styles.feature}>From 10+ professional designers</li>
                <li className={styles.feature}>Larger designer prize</li>
                <li className={styles.feature}>Unlimited revisions</li>
                <li className={styles.feature}>Full copyright</li>
                <li className={styles.feature}>Money back guarantee*</li>
                <li className={styles.feature}>Priority support</li>
              </ul>
              <div className={styles.buttonWrapper}>
                <Button onClick={() => { setMaxSpotsCount(10) }} selected={maxSpotsCount === 10}>{maxSpotsCount === 10 ? 'Selected' : 'Select'}</Button>
              </div>
            </PackagePanel>

            <PackagePanel
              name="Full Agency"
              price="$1200"
            >
              <ul className={styles.features}>
                <li className={styles.feature}><strong>Delivered by our full agency partner Gency.co</strong></li>
                <li className={styles.feature}>Expect 5 designs</li>
                <li className={styles.feature}>From 5 hand-picked designers</li>
                <li className={styles.feature}>Project intake call with a brand consultant</li>
                <li className={styles.feature}>Made to order solution</li>
                <li className={styles.feature}>Full copyright</li>
                <li className={styles.feature}>Dedicated account manager</li>
              </ul>
              <div className={styles.buttonWrapper}>
                <RequestCallModal trigger={<Button className={styles.request}>Request intake call</Button>} />
              </div>
            </PackagePanel>
          </div>
        </div>

        <div className={styles.ndaWrapper}>
          <div className={styles.ndaContent}>
            <div className={styles.ndaDescription}>

              <div className={styles.ndaHeader}>
                Make your project a secret (NDA)
              </div>

              <div className={styles.ndaText}>
                For just $35 you can keep your project a total secret with our ‘non disclosure agreement’. This way your project will stay out of any google searches, and also the designers have to agree to the secrecy terms before being able to read your briefing. See the text <StandartNdaModal/>.
              </div>
            </div>

            <div className={styles.ndaPriceWrapper}>
              <div className={styles.ndaPrice}>
                + {Dinero({ amount: standardNdaPrice }).toFormat('$0,0.00')}
              </div>
              <Button onClick={handleNdaChange} className={styles.ndaButton}>{ndaType === 'standard' ? 'Added' : 'Add'}</Button>
            </div>
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={
            <ContinueButton isValid={true}>Checkout →</ContinueButton>
          }
        />
      </form>
    </>
  )
}

export default Details
