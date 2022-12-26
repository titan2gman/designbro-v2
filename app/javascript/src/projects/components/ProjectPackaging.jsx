import _ from 'lodash'
import React from 'react'
import snakeCase from 'lodash/snakeCase'
import upperFirst from 'lodash/upperFirst'
import lowerCase from 'lodash/lowerCase'
import isEmpty from 'lodash/isEmpty'
import keys from 'lodash/keys'

import { getAgeInDays } from '@utils/dateTime'
import { cutAt } from '@utils/stringProcessor'

const MEASUREMENTS = [
  'width',
  'height',
  'volume',
  'diameter',
  'sideDepth',
  'frontWidth',
  'frontHeight',
  'labelWidth',
  'labelHeight'
]

const UploadedFile = ({ project }) => (
  <figure className="file-icon__item m-r-30">
    <a href={`${project.packagingMeasurements.technicalDrawingUrl}`} download>
      <div className="file-icon text-center in-white">
        <p className="file-icon__name text-ellipsis">
          {project.packagingMeasurements.fileExtension}
        </p>
        <p className="file-icon__text text-ellipsis">
          {Math.round(project.packagingMeasurements.filesize * 100) / 100} mb
        </p>
      </div>
    </a>
    <figcaption className="file-icon__details">
      <p className="file-icon__title">
        {cutAt(project.packagingMeasurements.filename, 14)}
      </p>
      <p className="file-icon__date in-grey-200 m-b-20">
        {getAgeInDays(project.createdAt)}
      </p>
      <div className="file-icon__action flex flex-wrap space-between">
        <a
          href={`${project.packagingMeasurements.technicalDrawingUrl}`}
          download
          className="file-icon__action-icon"
        >
          <i className="icon-download font-20 align-middle m-r-10" />
          <span className="font-12">Download</span>
        </a>
      </div>
    </figcaption>
  </figure>
)

const Measurement = ({ project, type, name }) => (
  <div>
    {project.packagingMeasurements[type] && <span>
      <span className="font-13 in-grey-500">{name}:</span> {project.packagingMeasurements[type]}
    </span>}
  </div>
)

export default ({ project }) => (
  <div className="brief-section" id="pouch-design">
    <p className="brief-section__title">
      {upperFirst(lowerCase(project.packagingType))} design
    </p>
    <div className="brief__package-example">
      <div>
        <div className="brief__package-example-img">
          <img
            src={`/${snakeCase(project.packagingType)}_img.png`}
            alt={`${snakeCase(project.packagingType)}-design`}
            srcSet={`/${snakeCase(project.packagingType)}_img_2x.jpg 2x`}
          />
          <div className="brief__package-example-text">
            <span>Package example</span>
          </div>
        </div>
      </div>
      <div>
        {!isEmpty(keys(project.packagingMeasurements).map((key) => MEASUREMENTS[key])) && <div className="m-b-50">
          <p className="font-13 in-grey-200 m-b-25">Measurements:</p>
          <Measurement project={project} type="width" name="Width" />
          <Measurement project={project} type="height" name="Height" />
          <Measurement project={project} type="volume" name="Volume" />
          <Measurement project={project} type="diameter" name="Diameter" />
          <Measurement project={project} type="sideDepth" name="Side depth" />
          <Measurement project={project} type="frontWidth" name="Front width" />
          <Measurement project={project} type="frontHeight" name="Front height" />
          <Measurement project={project} type="labelWidth" name="Label width" />
          <Measurement project={project} type="labelHeight" name="Label height" />
        </div>}

        {_.get(project, ['packagingMeasurements', 'technicalDrawingUrl']) && <div className="m-b-10">
          <p className="font-13 in-grey-200 m-b-25">Technical drawing:</p>
          <div>
            <UploadedFile project={project} />
          </div>
        </div>}
      </div>
    </div>
  </div>
)
