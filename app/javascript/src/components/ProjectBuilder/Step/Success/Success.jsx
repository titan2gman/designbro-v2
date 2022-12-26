import React, { useEffect } from 'react'
import Dinero from 'dinero.js'
import { useSelector } from 'react-redux'
import { Link, useParams } from 'react-router-dom'
import { meSelector } from '@selectors/me'

const Success = ({ project }) => {
  const { id } = useParams()
  const me = useSelector(meSelector)

  const projectPrice = Dinero({ amount: project ? project.normalizedPrice : 0 }).toFormat('0,0.00')

  useEffect(() => {
    if (window.ga) {
      window.ga('require', 'ecommerce')
      window.ga('ecommerce:addTransaction', { id })
      window.ga('ecommerce:send')
    }
  }, [])

  return (
    <main className="finish-step">
      {process.env.NODE_ENV === 'production' && me.projectsCount === 1 && project && (
        <img
          src={`https://www.shareasale.com/sale.cfm?tracking=${id}&amount=${projectPrice}&merchantID=103733&transtype=sale`}
          width="1"
          height="1"
        />
      )}
      <div className="left-panel">
      </div>
      <div className="right-panel">
        <h1>
          Awesome!
          <br/>
          You’re good to go!
        </h1>
        <h2>
          Expect the first designs within 24-48 hours so sit back & relax or read our tips & tricks to get the most out of your project
        </h2>

        <div className="links">
          <Link to="/c" className="">
            Go to my projects
          </Link>

          <a href="https://designbro.com/tips-tricks-logo-project" className="">
            Tips & Tricks
          </a>
        </div>
      </div>
    </main>
  )
}

export default Success
