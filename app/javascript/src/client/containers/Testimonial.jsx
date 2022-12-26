import { connect } from 'react-redux'
import TestimonialComponent from '@client/components/Testimonial'
import { getTestimonial } from '@reducers/testimonials'

const mapStateToProps = (state) => ({ testimonial: getTestimonial(state) })

export default connect(mapStateToProps)(TestimonialComponent)
