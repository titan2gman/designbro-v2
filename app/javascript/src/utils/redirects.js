export const getCheckoutRedirectPath = (id, productKey, upgradePackage) => {
  let page = 'success'

  // if (paymentType === 'bank_transfer') {
  //   page = 'invoice'
  // }

  if (productKey === 'brand-identity' || (productKey === 'logo' && upgradePackage === 'yes')) {
    page = 'stationery'
  }

  return `/projects/${id}/${page}?product=${productKey}`

}
