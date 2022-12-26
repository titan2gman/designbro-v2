import PropTypes from 'prop-types'
import React, { Component } from 'react'
import { ChromePicker } from 'react-color'
import enhanceWithClickOutside from 'react-click-outside'

const DefaultColorPickerContent = () => (
  <div>
    <i className="bfs-colorpicker__icon icon-color-bucket in-grey-200 m-b-15" />
    <p className="font-13 in-grey-200">Click to select color</p>
  </div>
)

const RequiredError = () => (
  <div className="main-input__hint in-pink-500 is-visible">
    Required.
  </div>
)

class ColorPicker extends Component {
  state = {
    visible: false,
    x: 0,
    y: 0
  }

  setColorPickerCoordinates = ({ nativeEvent: { layerX: x, layerY: y } }) => {
    this.setState({ visible: true, x, y })
  }

  handleClickOutside () {
    this.setState({ ...this.state, visible: false })
  }

  render () {
    return (
      <div className="col-xs-6 col-md-3 col-lg-2">
        {this.state.visible && (
          <div
            className="bfs-colorpicker__dropdown"
            style={{ top: this.state.y, left: this.state.x }}
          >
            <ChromePicker
              color={this.props.color}
              onChangeComplete={this.props.pickColor}
              disableAlpha
            />
          </div>
        )}

        <div className="bfs-colorpicker">
          {this.props.color && (
            <div className="cursor-pointer bfs-colorpicker__delete-color" onClick={this.props.removeColor}>
              <i className="icon-cross" />
            </div>
          )}
          <div className="bfs-colorpicker__text"
            style={{ background: this.props.color }}
            onClick={this.setColorPickerCoordinates}
          >
            {!this.props.color && <DefaultColorPickerContent />}
          </div>
        </div>
      </div>
    )
  }
}

ColorPicker.propTypes = {
  setProjectColorByIndex: PropTypes.func.isRequired,
  showErrors: PropTypes.bool,
  color: PropTypes.string
}

export default enhanceWithClickOutside(ColorPicker)
