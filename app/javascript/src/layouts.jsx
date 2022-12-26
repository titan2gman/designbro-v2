import React from 'react'
import { Route, Redirect } from 'react-router-dom'
import { connect } from 'react-redux'
import isEmpty from 'lodash/isEmpty'

import { getMe } from '@reducers/me'

import Layout from './views/Layout'
import SigninLayout from '@components/SigninLayout'
import DesignerSignupLayout from '@components/SignupLayout'
import DarkFooterLayout from '@components/DarkFooterLayout'

export const withLayout = (LayoutComponent, theme) => (View) => (props) => {
  return (
    <LayoutComponent theme={theme}>
      <View {...props} />
    </LayoutComponent>
  )
}

export const withAppLayout = withLayout(Layout, 'light')
export const withDarkAppLayout = withLayout(Layout, 'dark')

export const withSigninLayout = withLayout(SigninLayout)
export const withDesignerSignupLayout = withLayout(DesignerSignupLayout)
export const withDarkFooterLayout = withLayout(DarkFooterLayout)
