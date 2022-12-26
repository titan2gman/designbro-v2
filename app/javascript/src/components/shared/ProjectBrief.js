import React from 'react'

import { humanizeProjectTypeName } from '@utils/humanizer'
import { renderAsParagraphs } from '@utils/renderHelpers'

import ProjectExistingLogos from '@projects/components/ProjectExistingLogos'
import ProjectCompetitors from '@projects/components/ProjectCompetitors'
import ProjectColors from '@projects/containers/ProjectColors'
import ProjectBrandIdentity from '@projects/components/ProjectBrandIdentity'
import ProjectInspiration from '@projects/components/ProjectInspiration'
import ProjectTargetAudience from '@projects/components/ProjectTargetAudience'
import ProjectPackaging from '@projects/components/ProjectPackaging'
import ProjectAdditionalDocument from '@projects/components/ProjectAdditionalDocument'
import ProjectExamples from '@projects/components/ProjectExamples'
import ProjectStockImages from '@projects/components/ProjectStockImages'

const ProjectBrief = ({
  project,
  product,
  brand,
  brandDna,
  goodExamples,
  badExamples,
  competitors,
  colorsExist,
  inspirations,
  existingLogos,
  additionalDocuments,
  stockImages,
  areSpotStatesIntersecting,
  children,
  newExamples
}) => {

  return (
    <main className="project-brief">
      <div className="brief-page">
        <div className="row">
          <div className="brief-page__menu col-md-2 hidden-md-down">
            <ul>
              {['brand-identity'].includes(project.productKey) && areSpotStatesIntersecting && (
                <li className="brief-page__menu-item">
                  <a href="#stationery"
                    className="brief-page__menu-link main-button-link main-button-link--grey-pink">Stationery
                  </a>
                </li>
              )}

              <li className="brief-page__menu-item">
                <a href="#brief" className="brief-page__menu-link main-button-link main-button-link--grey-pink">Brief</a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#existing-design" className="brief-page__menu-link main-button-link main-button-link--grey-pink">Existing
                  Design
                </a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#competitors"
                  className="brief-page__menu-link main-button-link main-button-link--grey-pink">Competitors
                </a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#examples"
                  className="brief-page__menu-link main-button-link main-button-link--grey-pink">Examples
                </a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#brand-identity" className="brief-page__menu-link main-button-link main-button-link--grey-pink">Brand
                  DNA
                </a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#colors"
                  className="brief-page__menu-link main-button-link main-button-link--grey-pink">Colors
                </a>
              </li>
              <li className="brief-page__menu-item">
                <a href="#target-audience" className="brief-page__menu-link main-button-link main-button-link--grey-pink">Target
                  Audience
                </a>
              </li>
            </ul>
          </div>
          <div className="col-md-8">
            {['packaging'].includes(project.productKey) && (existingLogos.length > 0 || project.sourceFilesShared) && (
              <ProjectExistingLogos
                existingLogos={existingLogos}
                project={project}
              />
            )}

            {['packaging'].includes(project.productKey) && competitors.length > 0 && (
              <ProjectCompetitors competitors={competitors}/>
            )}

            {['brand-identity'].includes(project.productKey) && (
              <div className="brief-section" id="stationery">
                <p className="brief-section__title">Stationery</p>
                <div className="brief-section__info">
                  <p className="brief__title--sm">Front business card details</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(project.frontBusinessCardDetails)}
                  </div>
                </div>
                <div className="brief-section__info">
                  <p className="brief__title--sm">Back business card details</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(project.backBusinessCardDetails)}
                  </div>
                </div>
                <div className="brief-section__info">
                  <p className="brief__title--sm">Letter head</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(project.letterHead)}
                  </div>
                </div>
                <div className="brief-section__info">
                  <p className="brief__title--sm">Compliment</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(project.compliment)}
                  </div>
                </div>
              </div>
            )}

            <div className="brief-section" id="brief">
              {/* for all products */}
              <div className="brief-section__info">
                <p className="brief__title--sm">Project type</p>
                <p className="font-bold">
                  {humanizeProjectTypeName(project.productKey)}
                </p>
              </div>

              {['website'].includes(project.productKey) && (
                <div className="brief-section__info">
                  <p className="brief__title--sm">Number of pages to be designed</p>
                  <p>{project.maxScreensCount}</p>
                </div>
              )}

              {['manual'].includes(project.productKey) && (
                <div className="brief-section__info">
                  <p className="brief__title--sm">Name</p>
                  <p className="font-bold">{project.name}</p>
                </div>
              )}

              {/* for all products */}
              <div className="brief-section__info">
                <p className="brief__title--sm">Brand Name</p>
                <p className="font-bold">{brand.name}</p>
              </div>

              {['logo', 'logo2', 'brand-identity'].includes(project.productKey) && (
                <div className="brief-section__info">
                  <p className="brief__title--sm">Slogan</p>
                  <p>{brand.slogan}</p>
                </div>
              )}

              {['logo', 'logo2', 'brand-identity', 'packaging'].includes(project.productKey) && (
                <div className="brief-section__info">
                  {['packaging'].includes(project.productKey) && (
                    <p className="brief__title--sm">Additional text for package</p>
                  )}
                  {['logo', 'logo2', 'brand-identity'].includes(project.productKey) && (
                    <p className="brief__title--sm">Additional text for logo</p>
                  )}
                  <div className="font-bold">
                    {renderAsParagraphs(brand.additionalText)}
                  </div>
                </div>
              )}

              {['logo', 'logo2', 'brand-identity'].includes(project.productKey) && (
                <div className="brief-section__info">
                  <p className="brief__title--sm">Brand description</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(brand.description)}
                  </div>
                </div>
              )}

              {['logo', 'logo2', 'brand-identity', 'website', 'website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube', 'manual'].includes(project.productKey) && (
                <div className="brief-section">
                  <p className="brief-section__title">Ideas or special requirements</p>
                  <div className="brief-section__info">
                    {renderAsParagraphs(project.ideasOrSpecialRequirements)}
                  </div>
                </div>
              )}

              {['zoom-background'].includes(project.productKey) && (
                <div className="brief-section">
                  <p className="brief-section__title">What would you like us to create?</p>
                  <div className="brief-section__info">
                    {renderAsParagraphs(project.ideasOrSpecialRequirements)}
                  </div>
                </div>
              )}

              {['packaging'].includes(project.productKey) && (
                <>
                  <div className="brief-section__info">
                    <p className="brief__title--sm">Background story</p>
                    <div className="brief__comment-text">
                      {renderAsParagraphs(brand.backgroundStory)}
                    </div>
                  </div>

                  <div className="brief-section__info">
                    <p className="brief__title--sm">What is special</p>
                    <div className="brief__comment-text">
                      {renderAsParagraphs(brand.whatIsSpecial)}
                    </div>
                  </div>

                  <div className="brief-section__info">
                    <p className="brief__title--sm">Where it is used</p>
                    <div className="brief__comment-text">
                      {renderAsParagraphs(brand.whereItIsUsed)}
                    </div>
                  </div>

                  <div className="brief-section">
                    <p className="brief-section__title">Ideas or special requirements</p>
                    <div className="brief-section__info">
                      {renderAsParagraphs(project.ideasOrSpecialRequirements)}
                    </div>
                  </div>

                  <ProjectPackaging project={project}/>
                </>
              )}
            </div>

            {['website', 'website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post'].includes(project.productKey) && (
              <div className="brief-section__info">
                <p className="brief__title--sm">Background story</p>
                <div className="brief__comment-text">
                  {renderAsParagraphs(brand.backgroundStory)}
                </div>
              </div>
            )}

            {['website', 'website-banner', 'flyer', 'poster', 'menu', 'zoom-background', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post'].includes(project.productKey) && (
              <div className="brief-section__info">
                <p className="brief__title--sm">{product.productTextLabel}</p>
                <div className="brief__comment-text">
                  {renderAsParagraphs(project.productText)}
                </div>
              </div>
            )}

            {['facebook', 'twitter', 'linkedin', 'youtube'].includes(project.productKey) && (
              <div className="brief-section__info">
                <p className="brief__title--sm">Background story</p>
                <div className="brief__comment-text">
                  {renderAsParagraphs(brand.backgroundStory)}
                </div>
              </div>
            )}

            {['flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card'].includes(project.productKey) && (
              <div className="brief-section__info">
                <p className="brief__title--sm">{product.productSizeLabel}</p>
                <div className="brief__comment-text">
                  {renderAsParagraphs(project.productSize)}
                </div>
              </div>
            )}

            {['website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post'].includes(project.productKey) && (
              <>
                <div className="brief-section__info">
                  <p className="brief__title--sm">{product.whatIsItForLabel}</p>
                  <div className="brief__comment-text">
                    {renderAsParagraphs(project.whatIsItFor)}
                  </div>
                </div>
              </>
            )}

            {['website', 'website-banner', 'flyer', 'poster', 'menu', 'zoom-background', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube'].includes(project.productKey) && (
              <ProjectStockImages
                stockImagesExist={project.stockImagesExist}
                stockImages={stockImages}
              />
            )}

            {['logo', 'logo2', 'brand-identity', 'website', 'website-banner', 'flyer', 'poster', 'menu', 'zoom-background', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube'].includes(project.productKey) && (existingLogos.length > 0 || project.sourceFilesShared) && (
              <ProjectExistingLogos
                existingLogos={existingLogos}
                project={project}
              />
            )}

            {['website', 'website-banner', 'flyer', 'poster', 'menu', 'zoom-background', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube'].includes(project.productKey) && existingLogos.length === 0 && !project.sourceFilesShared && (
              <div className="brief-section__info" id="existing-design">
                <p className="brief-section__title">Existing design</p>
                <p className="font-bold">Don't need a logo to be featured on my {product.shortName}</p>
              </div>
            )}

            {['logo', 'logo2', 'brand-identity'].includes(project.productKey) && competitors.length > 0 && (
              <ProjectCompetitors competitors={competitors}/>
            )}

            {['logo', 'brand-identity'].includes(project.productKey) && (
              <ProjectExamples goodExamples={goodExamples} badExamples={badExamples}/>
            )}

            {['logo2'].includes(project.productKey) && (
              <ProjectExamples goodExamples={newExamples} badExamples={badExamples}/>
            )}

            {['logo', 'logo2', 'brand-identity', 'website', 'website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube'].includes(project.productKey) && (
              <ProjectBrandIdentity brandDna={brandDna}/>
            )}

            {['logo', 'logo2', 'brand-identity', 'website', 'website-banner', 'flyer', 'poster', 'menu', 'billboard', 'book-cover', 'album-cover', 'magazine-cover', 't-shirt', 'business-card', 'instagram-post', 'facebook', 'twitter', 'linkedin', 'youtube', 'manual'].includes(project.productKey) && inspirations.length > 0 && (
              <ProjectInspiration inspirations={inspirations}/>
            )}

            {['packaging'].includes(project.productKey) && (
              <ProjectBrandIdentity brandDna={brandDna}/>
            )}

            {/* for all products */}
            {colorsExist && (
              <ProjectColors/>
            )}

            {['packaging'].includes(project.productKey) && inspirations.length > 0 && (
              <ProjectInspiration inspirations={inspirations}/>
            )}

            {['logo', 'logo2', 'brand-identity', 'packaging', 'website', 'manual'].includes(project.productKey) && (
              <ProjectAdditionalDocument
                additionalDocuments={additionalDocuments}
                project={project}
              />
            )}

            {!['zoom-background'].includes(project.productKey) && (
              <ProjectTargetAudience brandDna={brandDna}/>
            )}

            {children}
          </div>
        </div>
      </div>
    </main>
  )}

ProjectBrief.defaultProps = {
  areSpotStatesIntersecting: true
}

export default ProjectBrief
