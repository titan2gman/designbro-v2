import React from 'react'
import { Link } from 'react-router-dom'

import { staticHost } from '@utils/hosts'

import TermsModal from '@components/modals/TermsModal'
import PrivacyPolicyModal from '@components/modals/PrivacyPolicyModal'

const FooterBrand = ({ children, userType }) =>
  (<div>
    {userType
      ? <Link to="/" className="main-footer__brand">{children}</Link>
      : <a href={staticHost} className="main-footer__brand">{children}</a>
    }
  </div>)

const Footer = ({ userType }) => (
  <footer className="main-footer bg-black">
    <div className="container">
      <div className="row">
        <div className="col-lg-2 col-xl-3">
          <FooterBrand userType={userType}>
            <img src="/projects/logo_grey.svg" alt="logo gray" />
          </FooterBrand>
        </div>
        <div className="col-lg-2">
          <ul className="main-footer__list">
            <li>
              {userType
                ? <Link to="/" className="main-footer__list-link hidden-md-down">Home</Link>
                : <a href={staticHost} className="main-footer__list-link hidden-md-down">Home</a>
              }
            </li>
            <li>
              <a href={`${staticHost}/design-project-types`} className="main-footer__list-link">Start a Project</a>
            </li>
            <li>
              <a href="https://designbro.com/blog" className="main-footer__list-link">Blog</a>
            </li>
          </ul>
        </div>
        <div className="col-lg-3 col-xl-2 hidden-md-down">
          <ul className="main-footer__list">
            <li>
              <a href={`${staticHost}/logo-design`} className="main-footer__list-link main-footer__list-link--reverse">Logo</a>
            </li>
            <li>
              <a href={`${staticHost}/brand-identity-design`} className="main-footer__list-link main-footer__list-link--reverse">Brand identity</a>
            </li>
            <li>
              <a href={`${staticHost}/packaging-design`} className="main-footer__list-link main-footer__list-link--reverse">Packaging</a>
            </li>
          </ul>
        </div>
        <div className="col-lg-3 col-xl-2">
          <ul className="main-footer__list">
            <li>
              <a href={`${staticHost}/faq`} className="main-footer__list-link">Help</a>
            </li>
            <li>
              <Link to="/login" className="main-footer__list-link">Login</Link>
            </li>
            <li>
              <Link to="/d/signup" className="main-footer__list-link">Join as a Designer</Link>
            </li>
          </ul>
        </div>
        <div className="col-lg-2">
          <ul className="main-footer__list">
            <li>
              <TermsModal linkClasses="main-footer__list-link cursor-pointer" />
            </li>
            <li>
              <PrivacyPolicyModal linkClasses="main-footer__list-link cursor-pointer" />
            </li>
            <li>
              <a href={`${staticHost}/contact-us`} className="main-footer__list-link">Contact Us</a>
            </li>
          </ul>
        </div>
      </div>
      <div className="main-footer__socials">
        <a target="_blank" className="main-footer__social icon-fb-circle" href="https://fb.me/designbrocom" />
        <a target="_blank" className="main-footer__social icon-instagram-circle" href="https://www.instagram.com/designbrodotcom" />
        <a target="_blank" className="main-footer__social icon-pinterest-circle" href="https://www.pinterest.com/designbrodotcom" />
        <a target="_blank" className="main-footer__social icon-twitter-circle" href="https://twitter.com/designbrodotcom" />
      </div>
      <p className="main-footer__rights">{new Date().getFullYear()} © DesignBro. All Rights reserved.</p>
    </div>
  </footer>
)

export default Footer
