import React from 'react'
import { connect } from 'react-redux'
import { getModal } from '@reducers/modal'

import AgreeNdaModal from '@designer/containers/AgreeNdaModal'

import ApproveFilesModal from '@projects/containers/ApproveFilesModal'
import BlockDesignerModal from '@project/containers/BlockDesignerModal'
import EliminateWorkModal from '@project/containers/EliminateWorkModal'
import StartNewProjectModal from '@projects/containers/StartNewProjectModal'
import SourceFilesUploadModal from '@components/SourceFilesUploadModal'

import SuccessModal from '@modals/success/SuccessModal'
import DeliverablesModal from '@modals/designer-deliverables/DeliverablesModal'
import ComingSoonModal from '@modals/coming-soon/containers/ComingSoonModal'
import LeaveReviewModal from '@modals/leave-review/containers/LeaveReviewModal'
import ClientLoginModal from '@modals/client-login/components/ClientLoginModal'
import ReserveSpotModal from '@modals/reserve-spot/containers/ReserveSpotModal'
import ClientVideoModal from '@modals/client-video/containers/ClientVideoModal'
import ClientSignupModal from '@modals/client-signup/components/ClientSignupModal'
import DesignerVideoModal from '@modals/designer-video/containers/DesignerVideoModal'
import WrongFileFormatModal from '@modals/wrong-file-format/containers/WrongFileFormatModal'
import DesignerShareConfirmModal from '@modals/designer-share-confirm/containers/DesignerShareConfirmModal'

import InitialBrandsModal from '@components/ProjectBuilder/New/BrandsModal'
import BrandsModal from '@components/ProjectBuilder/Step/BrandsModal'
import DesignerOrContestDecisionModal from '@components/ProjectBuilder/New/DesignerOrContestDecisionModal'
import PaymentModal from '@components/ProjectBuilder/New/PaymentModal'
import GetQuoteModal from '@components/ProjectBuilder/New/GetQuoteModal'
import PaymentSuccessModal from '@components/ProjectBuilder/New/PaymentSuccessModal'
import SuccessMessageModal from '@components/ProjectBuilder/New/SuccessMessageModal'

import ExistingLogoModal from '@components/ProjectBuilder/Step/ExistingLogoModal'

import ConfirmationModal from '@components/modals/ConfirmationModal'

import AdditionalSpotsModal from '@components/client-project/AdditionalSpotsModalContainer'
import AdditionalSpotsPaymentModal from '@components/client-project/AdditionalSpotsPaymentModalContainer'

import AdditionalDaysModal from '@components/client-project/AdditionalDaysModalContainer'
import AdditionalDaysPaymentModal from '@components/client-project/AdditionalDaysPaymentModalContainer'

import SignInModal from '../features/new-project-builder/components/SignInModal'
import SignUpModal from '../features/new-project-builder/components/SignUpModal'

const MODAL_COMPONENTS = {
  SUCCESS: SuccessModal,
  AGREE_NDA: AgreeNdaModal,
  COMING_SOON: ComingSoonModal,
  LEAVE_REVIEW: LeaveReviewModal,
  RESERVE_SPOT: ReserveSpotModal,
  CLIENT_VIDEO: ClientVideoModal,
  CLIENT_LOGIN: ClientLoginModal,
  CLIENT_SIGNUP: ClientSignupModal,
  APPROVE_FILES: ApproveFilesModal,
  DESIGNER_VIDEO: DesignerVideoModal,
  BLOCK_DESIGNER: BlockDesignerModal,
  ELIMINATE_WORK: EliminateWorkModal,
  START_NEW_PROJECT: StartNewProjectModal,
  WRONG_FILE_FORMAT: WrongFileFormatModal,
  DESIGNER_SHARE_CONFIRM: DesignerShareConfirmModal,
  SOURCE_FILES_CHECKLIST: SourceFilesUploadModal,
  EXISTING_LOGO: ExistingLogoModal,
  DELIVERABLES_MODAL: DeliverablesModal,
  DESIGNER_OR_CONTEST_DECISION: DesignerOrContestDecisionModal,
  PAYMENT_MODAL: PaymentModal,
  PAYMENT_SUCCESS_MODAL: PaymentSuccessModal,
  GET_QUOTE_MODAL: GetQuoteModal,
  SUCCESS_MESSAGE_MODAL: SuccessMessageModal,
  INITIAL_BRANDS_MODAL: InitialBrandsModal,
  BRANDS_MODAL: BrandsModal,
  CONFIRMATION_MODAL: ConfirmationModal,
  ADDITIONAL_SPOTS_MODAL: AdditionalSpotsModal,
  ADDITIONAL_SPOTS_PAYMENT_MODAL: AdditionalSpotsPaymentModal,
  ADDITIONAL_DAYS_MODAL: AdditionalDaysModal,
  ADDITIONAL_DAYS_PAYMENT_MODAL: AdditionalDaysPaymentModal,
  'new-project-builder/SIGN_IN_MODAL': SignInModal,
  'new-project-builder/SIGN_UP_MODAL': SignUpModal

}

const ModalRoot = ({ modalType, modalProps }) => {
  if (modalType) {
    const element = MODAL_COMPONENTS[modalType]
    return React.createElement(element, modalProps)
  }

  return <div className="no-open-modals" />
}

export default connect(getModal)(ModalRoot)
