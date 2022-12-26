import React from 'react'
import { Link, useParams } from 'react-router-dom'
import { useSelector } from 'react-redux'
import Dinero from 'dinero.js'
import styles from './SuccessStep.module.scss'
import { meSelector } from '@selectors/me'
import { projectSelector } from '@selectors/newProjectBuilder'

const SuccessStep = () => {
  const { projectId } = useParams()
  const project = useSelector(projectSelector)
  const me = useSelector(meSelector)
  const projectPrice = Dinero({ amount: project.normalizedPrice }).toFormat('0,0.00')

  return (
    <main className={styles.finishStep}>
      {process.env.NODE_ENV === 'production' && me.projectsCount === 1 && (
        <img
          src={`https://www.shareasale.com/sale.cfm?tracking=${projectId}&amount=${projectPrice}&merchantID=103733&transtype=sale`}
          width="1"
          height="1"
        />
      )}
      <div className={styles.leftPanel}>
      </div>
      <div className={styles.rightPanel}>
        <h1 className={styles.headline}>
          Awesome!
          <br/>
          You’re good to go!
        </h1>
        <h2 className={styles.subheadline}>
          Expect the first designs within 24-48 hours so sit back & relax or read our tips & tricks to get the most out of your project
        </h2>

        <div className={styles.links}>
          <Link to="/c" className={styles.link}>
            Go to my projects
          </Link>

          <a href="https://designbro.com/tips-tricks-logo-project" className={styles.link}>
            Tips & Tricks
          </a>
        </div>
      </div>
    </main>
  )
}

export default SuccessStep
