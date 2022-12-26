export const showModal = (type, props) => ({
  type: 'SHOW_MODAL',
  modalProps: props,
  modalType: type
})

export const showClientVideoModal = () => (
  showModal('CLIENT_VIDEO')
)

export const showDesignerVideoModal = () => (
  showModal('DESIGNER_VIDEO')
)

export const showClientLoginModal = () => (
  showModal('CLIENT_LOGIN')
)

export const showClientSignUpModal = () => (
  showModal('CLIENT_SIGNUP')
)

export const showDesignerShareConfirmModal = (props) => (
  showModal('DESIGNER_SHARE_CONFIRM', props)
)

export const showFinishStepLogoModal = () => (
  showModal('EXISTING_LOGO')
)

export const showSuccessModal = (props) => (
  showModal('SUCCESS', props)
)

export const showDeliverablesModal = (props) => {
  return showModal('DELIVERABLES_MODAL', props)
}

export const showInitialBrandsModal = () => {
  return showModal('INITIAL_BRANDS_MODAL')
}

export const showBrandsModal = () => {
  return showModal('BRANDS_MODAL')
}

export const showPaymentModal = () => {
  return showModal('PAYMENT_MODAL')
}

export const showGetQuoteModal = () => {
  return showModal('GET_QUOTE_MODAL')
}

export const showSuccessMessageModal = () => {
  return showModal('SUCCESS_MESSAGE_MODAL')
}

export const showAdditionalSpotsModal = () => {
  return showModal('ADDITIONAL_SPOTS_MODAL')
}

export const showAdditionalSpotsPaymentModal = () => {
  return showModal('ADDITIONAL_SPOTS_PAYMENT_MODAL')
}

export const showAdditionalTimeModal = (props) => {
  return showModal('ADDITIONAL_DAYS_MODAL', props)
}

export const showAdditionalDaysPaymentModal = (props) => {
  return showModal('ADDITIONAL_DAYS_PAYMENT_MODAL', props)
}

export const showSignInModal = (props) => {
  return showModal('new-project-builder/SIGN_IN_MODAL', props)
}

export const showSignUpModal = (props) => {
  return showModal('new-project-builder/SIGN_UP_MODAL', props)
}

export const hideModal = () => ({
  type: 'HIDE_MODAL'
})
