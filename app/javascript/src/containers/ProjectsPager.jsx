import { connect } from 'react-redux'

import { changePage } from '@actions/projects'
import { getProjectsPager } from '@reducers/projects'

import Pager from '@components/Pager'

const mapStateToProps = getProjectsPager

const mapDispatchToProps = (dispatch, { loadProjects }) => ({
  onClick (page) {
    dispatch(changePage(page))

    loadProjects()
  }
})

export default connect(mapStateToProps, mapDispatchToProps)(Pager)
