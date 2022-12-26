import React from 'react'
import times from 'lodash/times'
import ContentEditable from 'react-contenteditable'
import Autolinker from 'autolinker'

var autolinker = new Autolinker( {
  urls : true,
} )

export default ({ competitors }) => (
  <div className="brief-section" id="competitors">
    <p className="brief-section__title">Competitors</p>
    {competitors.map((competitor) => (
      <div className="brief__competitor" key={competitor.id}>
        <div className="brief__competitor-info">
          <div className="brief__competitor-img">
            <img src={competitor.url} alt="competitor" />
          </div>
          <div>
            <p className="m-b-5">{competitor.name}</p>
            {competitor.website && 
              <a
                href={autolinker.parse(competitor.website)[0].getUrl()}
                target="_blank"
                rel="noopener norefferer"
                className="main-button-link main-button-link--grey-pink text-underline font-13 m-b-30"
              >
                {competitor.website}
              </a>
            }
            <div className="brief__stars">
              <p className="font-13 in-grey-200 m-b-10 m-r-15">
                Rate the design
              </p>
              <div className="dpj-content__stars">
                {times(competitor.rate, (index) => (
                  <i key={index} className="icon-star in-green-500" />
                ))}

                {times(5 - competitor.rate, (index) => (
                  <i key={5 - index} className="icon-star in-grey-200" />
                ))}
              </div>
            </div>
          </div>
        </div>
        {competitor.comment && (
          <span>
            <p className="brief__title--sm m-b-5">Comment</p>
            <p className="brief__comment-text brief__comment-text--sm">
              <ContentEditable html={competitor.comment} disabled />
            </p>
          </span>
        )}
      </div>
    ))}
  </div>
)
