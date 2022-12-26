import { connect } from 'react-redux'

import { generateDownloadUrl } from '@utils/receipts'

import ClientTransaction from '@client/components/transactions/ClientTransaction'

const mapStateToProps = ({ authHeaders }, { payment: { id } }) => ({
  downloadUrl: generateDownloadUrl(authHeaders, id)
})

export default connect(mapStateToProps)(ClientTransaction)
