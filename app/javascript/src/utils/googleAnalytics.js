export const saveGACheckoutEvent = ({ product, price, step }) => {
  if (window.dataLayer) {
    dataLayer.push({
      event: 'ecCheckout',
      eventCategory: 'Enhanced Ecommerce',
      eventAction: 'Checkout',
      eventLabel: step.path,
      ecommerce: {
        currencyCode: 'USD',
        checkout: {
          actionField: {
            step: step.position
          },
          products: [{
            name: `${product.name} Design`, // Product name
            id: product.id, // ID for product, if not exist you can write name here too.
            price, // Price of product
            brand: 'DesignBro', // Constant, if there are another brand on website, it should be here
            category: product.productCategoryName, // Category of product should be here
            variant: '', // It can be empty
            quantity: '1', // How many unit-piece purchased. If there are more than 1 product it should 2-3

            list: 'Popular Projects',// ”Information of List”
            position: '1', // Information of which order it displayed

            //Related dimensions will be here.
            dimensionA: 'USD' // Currency
          }]
        }
      }
    })
  }
}

export const saveGAPurchaseEvent = ({ product, id, price }) => {
  if (window.dataLayer) {
    dataLayer.push({
      event: 'ecPurchase',
      eventCategory: 'Enhanced Ecommerce',
      eventAction: 'Purchase',
      eventLabel: 'Purchase',
      ecommerce: {
        currencyCode: 'USD',
        purchase: {
          actionField: {
            id, // Order ID
            // affiliation: '', // It will be null
            // revenue: '12.99', // Total cart revenue. Decimal seperator will be point.
            // tax: 0, //Tax
            // shipping: '0', //It will be zero.(There is no shipping)
            // coupon: 'Facebook' //If coupon used, it will be name of the coupon.
          },
          products: [{
            name: `${product.name} Design`, // Product name
            id: product.id, // ID for product, if not exist you can write name here too.
            price, // Price of product
            brand: 'DesignBro', // Constant, if there are another brand on website, it should be here
            category: product.productCategoryName, // Category of product should be here
            variant: '', // It can be empty
            quantity: '1', // How many unit-piece purchased. If there are more than 1 product it should 2-3

            list: 'Popular Projects',// ”Information of List”
            position: '1', // Information of which order it displayed

            //Related dimensions will be here.
            dimensionA: 'USD' // Currency
          }]
        }
      }
    })
  }
}
