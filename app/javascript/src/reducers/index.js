import { combineReducers } from 'redux'
import { connectRouter } from 'connected-react-router'
import { history } from '../history'

import me from './me'
import ndas from './ndas'
import forms from './forms'
import modal from './modal'
import spots from './spots'
import clients from './clients'
import payouts from './payouts'
import designs from './designs'
import entities from './entities'
import projects from './projects'
import faqItems from './faqItems'
import payments from './payments'
import earnings from './earnings'
import vatRates from './vatRates'
import faqGroups from './faqGroups'
import ndaPrices from './ndaPrices'
import myProjects from './myProjects'
import newProject from './newProject'
import comingSoon from './comingSoon'
import portfolios from './portfolios'
import authHeaders from './authHeaders'
import simpleModal from './simpleModal'
import sourceFiles from './sourceFiles'
import designerNdas from './designerNdas'
import testimonials from './testimonials'
import brandExamples from './brandExamples'
import projectColors from './projectColors'
import designerStats from './designerStats'
import designVersions from './designVersions'
import portfolioWorks from './portfolioWorks'
import projectDiscount from './projectDiscount'
import portfolioImages from './portfolioImages'
import directConversation from './directConversation'
import competitors from './competitors'
import inspirations from './inspirations'
import projectBrandExamples from './projectBrandExamples'
import projectNewBrandExamples from './projectNewBrandExamples'
import existingDesigns from './existingDesigns'
import projectAdditionalDocuments from './projectAdditionalDocuments'
import products from './products'
import productCategories from './productCategories'
import validations from './validations'
import brands from './brands'
import designer from './designer'
import reviews from './reviews'
import projectStockImages from './projectStockImages'
import featuredImages from './featuredImages'
import projectBuilder from './projectBuilder'
import finalistDesigners from './finalistDesigners'
import client from './client'

import {
  newProjectBuilderReducer as newProjectBuilder,
  brandsReducer as newProjectBuilderBrands,
  brandExamplesReducer as newProjectBuilderBrandExamples,
  productsReducer as newProjectBuilderProducts,
  ndaPricesReducer as newProjectBuilderNdaPrices,
  vatRatesReducer as newProjectBuilderVatRates,
  discountReducer as newProjectBuilderDiscount
} from '../features/new-project-builder'

const appReducer = combineReducers({
  me,
  ndas,
  forms,
  modal,
  spots,
  clients,
  payouts,
  designs,
  vatRates,
  earnings,
  entities,
  faqItems,
  projects,
  payments,
  faqGroups,
  ndaPrices,
  myProjects,
  newProject,
  comingSoon,
  portfolios,
  authHeaders,
  simpleModal,
  sourceFiles,
  designerNdas,
  testimonials,
  brandExamples,
  projectColors,
  designerStats,
  designVersions,
  portfolioWorks,
  projectDiscount,
  portfolioImages,
  directConversation,
  competitors,
  inspirations,
  projectBrandExamples,
  projectNewBrandExamples,
  existingDesigns,
  projectAdditionalDocuments,
  products,
  productCategories,
  brands,
  validations,
  designer,
  reviews,
  projectStockImages,
  featuredImages,
  projectBuilder,
  finalistDesigners,
  client,
  newProjectBuilder,
  newProjectBuilderBrands,
  newProjectBuilderBrandExamples,
  newProjectBuilderProducts,
  newProjectBuilderNdaPrices,
  newProjectBuilderVatRates,
  newProjectBuilderDiscount,
  router: connectRouter(history),
})

const rootReducer = (state, action) => {
  if (action.type === 'SIGN_OUT_SUCCESS' ||
      action.type === 'SIGN_OUT_FAILURE') {
    state = undefined
  }

  return appReducer(state, action)
}

export default rootReducer
