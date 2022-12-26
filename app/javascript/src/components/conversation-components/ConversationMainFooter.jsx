import React from 'react'

const ConversationMainFooter = () => (
  <div className="conv-content__footer">
    <div className="viewer-info text-center">
      <span className="status-indicator in-white bg-black m-b-20">Winner</span>
      <div className="rating-stars m-b-10">
        <i className="icon-star in-green-500" />
        <i className="icon-star in-green-500" />
        <i className="icon-star in-green-500" />
        <i className="icon-star in-grey-200" />
        <i className="icon-star in-grey-200" />
      </div>
    </div>
    <div className="row p-t-20 p-b-10">
      <div className="col-lg-4 text-xs-center text-lg-left">
        <div className="main-button main-button--md main-button--grey-black conv-prev-version__btn m-b-10">
          <i className="icon-time-ago-circle font-24 conv-prev-version__icon p-r-10" />
          Previous versions
        </div>
      </div>
      <div className="col-md-4 text-center">
        <div className="main-button main-button--md main-button--black-pink font-12 m-b-10">
          Replace Design
        </div>
      </div>
      <div className="col-lg-4 text-xs-center text-lg-right hidden-sm-down">
        <div className="main-button main-button--md main-button--grey-black m-b-10">
          Uploaded files
        </div>
      </div>
    </div>
  </div>
)

export default ConversationMainFooter
