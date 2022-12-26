import { connect } from 'react-redux'

import Competitors from './Competitors'

const mapStateToProps = (state) => ({
  competitorsExist: state.projectBuilder.attributes.competitorsExist === 'yes',
  competitorUploaders: state.projectBuilder.attributes.competitors
})

export default connect(mapStateToProps)(Competitors)
