import React from 'react'
import { Modal } from 'semantic-ui-react'

const ImageModal = ({ onClose, imageUrl, isOpen }) => (
  <Modal
    open={isOpen}
    style={{ backgroundColor: 'rgba(0, 0, 0, 0.6)', width: '100%', height: '100%', margin: '0' }}
  >
    <div onClick={onClose} className="image-modal__close">&times;</div>
    <div className="image-modal__content">
      <div>
        <img src={imageUrl}/>
      </div>
    </div>
  </Modal>
)

export default ImageModal
