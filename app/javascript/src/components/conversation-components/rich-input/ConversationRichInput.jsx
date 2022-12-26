import _ from 'lodash'
import React, { useMemo, useState, useCallback, useEffect } from 'react'
import { createEditor, Editor, Transforms, Text, Node, Button } from 'slate'
import { Slate, Editable, withReact, DefaultElement } from 'slate-react'
import isHotkey from 'is-hotkey'
import escapeHtml from 'escape-html'
import 'emoji-mart/css/emoji-mart.css'
import { Picker } from 'emoji-mart'
import { useDropzone } from 'react-dropzone'
import Textarea from 'react-textarea-autosize'

import IconButton from './IconButton'
import DetectMessage from './DetectMessage'
import CurrentUserPic from '@containers/CurrentUserPic'

import iconBold from 'icon_bold.svg'
import iconItalic from 'icon_italic.svg'
import iconUnderline from 'icon_underline.svg'
import iconStrikethrough from 'icon_strikethrough.svg'
import iconEmoji from 'icon_emoji.svg'
import iconAttach from 'icon_attachment.svg'
import iconRightArrowWhite from 'icon_rightarrow_white.svg'

import iconBoldActive from 'icon_bold_active.svg'
import iconItalicActive from 'icon_italic_active.svg'
import iconUnderlineActive from 'icon_underline_active.svg'
import iconStrikethroughActive from 'icon_strikethrough_active.svg'
import iconEmojiActive from 'icon_emoji_active.svg'
import iconAttachActive from 'icon_attachment_active.svg'
import iconRightArrowGrey from 'icon_rightarrow_grey.svg'

/**------------------------ global constants ----------------------*/
// BEGIN
const slatejsEditableStyle = {
  padding: '5px 0',
  fontFamily: 'Montserrat',
  lineHeight: '17.5px',
  letterSpacing: '-0.22px',
  textAlign: 'left',
  color: '#5c5c5c',
  fontSize: '13px',
}

const initialState = [
  {
    type: 'paragraph',
    children: [{
      bold: false,
      emoji: false,
      italic: false,
      strikethrough: false,
      underline: false,
      text: ''
    }],
  },
]

const hotkeyMarks = {
  'mod+b': 'bold',
  'mod+i': 'italic',
  'mod+u': 'underline',
  'mod+s': 'strikethrough',
}

const hotkeyOthers = {
  'copy': 'mod+c',
  'paste': 'mod+v',
  'cut': 'mod+x',
  'selectAll': 'mod+a'
}

const marks = {
  bold: [iconBold, iconBoldActive],
  italic: [iconItalic, iconItalicActive],
  underline: [iconUnderline, iconUnderlineActive],
  strikethrough: [iconStrikethrough, iconStrikethroughActive]
}

const supportedFileTypes = [
  'ppt', 'pptx', 'jpg', 'jpeg', 'gif', 'png', 'doc', 'docx', 'ai', 'pdf', 'eps', 'indd', 'sketch', 'psd', 'svg', 'tiff'
]

const mediaFileTypes = [
  'jpg', 'jpeg', 'gif', 'png'
]

const detectMsgTexts = {
  email: {
    title: 'Whoops!',
    content: 'Just letting you know it\'s not permitted to work outside of the DesignBro platform.'
  },
  attach: {
    title: 'Sharing attachments',
    content: 'Please make sure that you don\'t upload designs from other designers in this contest.'
  },
  unsupportedFileType: {
    title: 'Oops... <span style=\'color: #5c5c5c;\'>This file type is not supported</span>',
    content: 'Supported file types: <br \>ppt, pptx, jpg, jpeg, gif, png, doc, docx, ai, pdf, eps, indd, sketch, psd, svg, tiff'
  }
}
//END

/**------------------------------------ slate editable -------------------------------- */
//BEGIN
const Leaf = props => {
  const isBold = props.leaf.bold
  const isUnderline = props.leaf.underline
  const isItalic = props.leaf.italic
  const isStrikethrough = props.leaf.strikethrough
  const isEmoji = props.leaf.emoji
  let textDecoration = ''
  textDecoration += isUnderline ? 'underline' : ''
  textDecoration += isStrikethrough ? ' line-through' : ''

  return (
    <span
      {...props.attributes}
      style={{
        fontWeight: isBold ? 'bold' : 'normal',
        fontStyle: isItalic ? 'italic' : 'normal',
        textDecoration: textDecoration,
        fontSize: isEmoji? '15.9px' : ''
      }}
    >
      {props.children}
    </span>
  )
}

const serialize = node => {
  if (Text.isText(node)) {
    let text = escapeHtml(node.text)
    node = {
      ...node,
      text
    }

    text = node.bold ? `<b>${text}</b>` : text
    text = node.italic ? `<i>${text}</i>` : text
    text = node.underline ? `<u>${text}</u>` : text
    text = node.strikethrough ? `<del>${text}</del>` : text
    text = node.emoji ? `<span class='emoji'>${text}</span>` : text
    return text
  }
  let children = node.children.map(n => serialize(n)).join('')
  children = children == '' ? '<br>' : children

  switch (node.type) {
  case 'quote':
    return `<blockquote><p>${children}</p></blockquote>`
  case 'paragraph':
    return `<p>${children}</p>`
  case 'link':
    return `<a href="${escapeHtml(node.url)}">${children}</a>`
  default:
    return children
  }
}

const toggleMark = (editor, format) => {
  const isActive = isMarkActive(editor, format)

  if (isActive) {
    Editor.removeMark(editor, format)
  } else {
    Editor.addMark(editor, format, true)
  }
  document.getElementById('editable').focus()
}

const isMarkActive = (editor, format) => {
  const marks = Editor.marks(editor)
  return marks ? marks[format] === true : false
}
//END

const ConversationRichInput = ({ onMessageSend, user }) => {
  const editor = useMemo(() => withReact(createEditor()), [])
  const [value, setValue] = useState(initialState)
  const [isTextEmpty, setIsTextEmpty] = useState(true)
  const [isFileEmpty, setIsFileEmpty] = useState(true)
  const [isEmailDetected, setIsEmailDetected] = useState(false)
  const [isEmojiPickerVisible, setIsEmojiPickerVisible] = useState(false)
  const [files, setFiles] = useState([])
  const [isDragEnter, setIsDragEnter] = useState(false)
  const [isAttachDetected, setIsAttachDetected] = useState(false)
  const [isUnsupportedFileDetected, setIsUnsupportedFileDetected] = useState(false)

  const [isTextMobileEmpty, setIsTextMobileEmpty] = useState(true)
  const [valueMobile, setValueMobile] = useState('')

  let dragCount = 0
  // decide emptiness
  useEffect(() => {
    setIsFileEmpty(_.isEmpty(files))
  }, [files])
  useEffect(() => {
    setIsTextEmpty(_.isEqual(initialState, value))
  }, [value])
  useEffect(() => {
    setIsTextMobileEmpty(_.isEqual('', valueMobile))
  }, [valueMobile])

  useEffect(() => {
    document.execCommand('defaultParagraphSeparator', false, 'p')

    const handleDragEnter = (e) => {
      dragCount++
      if (!isDragEnter) {
        setIsDragEnter(true)
      }
    }
    const handleDragLeave = (e) => {
      dragCount--
      if (dragCount === 0) {
        setIsDragEnter(false)
      }
    }
    const handleDrop = (e) => {
      if (!e.target.className.includes('conv-rich-input__dnd')) {
        setIsDragEnter(false)
        dragCount = 0
      }
    }
    document.addEventListener('dragenter', handleDragEnter)
    document.addEventListener('dragleave', handleDragLeave)
    document.addEventListener('drop', handleDrop)

    return () => {
      document.removeEventListener('dragenter', handleDragEnter)
      document.removeEventListener('dragleave', handleDragLeave)
      document.removeEventListener('drop', handleDrop)
    }
  }, [])

  // slate editable
  const handleKeyDown = (event) => {
    const convChatBodyBottom = document.getElementsByClassName('conv-chat__body-bottom')[0]
    convChatBodyBottom.scrollIntoView()
    for (const hotkey in hotkeyMarks) {
      if (isHotkey(hotkey, event)) {
        event.preventDefault()
        const mark = hotkeyMarks[hotkey]
        toggleMark(editor, mark)
        return
      }
    }

    if (isHotkey(hotkeyOthers['copy'], event)) {
      return
    } else if (isHotkey(hotkeyOthers['paste'], event)) {
      return
    } else if (isHotkey(hotkeyOthers['cut'], event)) {
      return
    }  else if (isHotkey(hotkeyOthers['selectAll'], event)) {
      return
    }

    if (event.key === '@') {
      event.preventDefault()
      if (isEmailDetected === false) {
        setIsEmailDetected(true)
      }
    }
    if (event.key.length === 1) {
      event.preventDefault()
      editor.insertNode({
        emoji: false,
        bold: isMarkActive(editor, 'bold'),
        italic: isMarkActive(editor, 'italic'),
        underline: isMarkActive(editor, 'underline'),
        strikethrough: isMarkActive(editor, 'strikethrough'),
        text: event.key
      })
    }


  }

  const handlePaste = (event) => {
    // event.preventDefault()
    const pasted = event.clipboardData.getData('text/plain')
    if (_.includes(pasted, '@') && isEmailDetected === false) {
      setIsEmailDetected(true)
    }
    // editor.insertData(event.clipboardData)
  }

  const handleEmailDetectMessgeClose = () => {
    setIsEmailDetected(null)
  }

  const handleAttachDetectMessgeClose = () => {
    setIsAttachDetected(null)
  }

  const handleUnsupportedFileDetectMessageClose = () => {
    setIsUnsupportedFileDetected(false)
  }

  const renderLeaf = useCallback(props => {
    return <Leaf {...props} />
  }, [])

  const handleChange = useCallback(_value => {
    setValue(_value)
  }, [])

  const handleTextareaChange = (e) => {
    const convChatBodyBottom = document.getElementsByClassName('conv-chat__body-bottom')[0]
    convChatBodyBottom.scrollIntoView()
    setValueMobile(e.target.value)
  }

  const handleClick = () => {
    let body = {
      text: '<p></p>',
      files: []
    }
    if (!isTextEmpty) {
      const htmlParsed = serialize({ type: 'paragraph', children: value })
      body = { ...body, text: htmlParsed }
      Editor.removeMark(editor, 'bold')

      // set selection to beginning of the input
      const point = { path: [0, 0], offset: 0 }
      editor.selection = { anchor: point, focus: point }

      // reset the history
      editor.history = { redos: [], undos: [] }
      setValue(initialState)
    }
    else if (!isTextMobileEmpty) {
      const valueMobileParsed =_.replace(valueMobile, new RegExp('\n', 'g'), '<br />')
      body = { ...body, text: valueMobileParsed }
      document.getElementsByClassName('conv-rich-input__textarea')[0].value = ''
      setValueMobile('')
    }
    if (!isFileEmpty) {
      body = { ...body, files }
      // Make sure to revoke the data uris to avoid memory leaks
      files.filter(file => file.preview !== undefined).forEach(file => URL.revokeObjectURL(file.preview))
      setFiles([])
    }

    onMessageSend(body)
  }

  const handleEmojiSelect = useCallback((emoji) => {
    editor.insertNode({
      emoji: true,
      text: ` ${emoji.native} `
    })
    setIsEmojiPickerVisible(false)
  }, [])

  // react dropzone
  const { getRootProps, getInputProps, open } = useDropzone({
    noClick: true,
    maxSize: 15000000,
    onDrop: acceptedFiles => {
      let file = acceptedFiles[0]
      const extension = _.split(file.name, '.')[1]
      if (_.includes(supportedFileTypes, extension)) {
        file = Object.assign(file, { extension: extension })
        if (_.includes(mediaFileTypes, extension)) {
          setFiles([...files, Object.assign(file, {
            preview: URL.createObjectURL(file)
          })])
        } else {
          setFiles([...files, file])
        }
        if (isAttachDetected === false) {
          setIsAttachDetected(true)
        }
      } else {
        setIsUnsupportedFileDetected(true)
      }
      setIsDragEnter(false)
      dragCount = 0
    }
  })

  const handleThumbClose = (deletePreview) => {
    const _files = files.filter(item => item.preview !== deletePreview)
    setFiles(_files)
  }

  const thumbs = files.map(file => (
    <div className="conv-rich-input__thumb" key={file.name}>
      {file.preview ? (
        <img
          src={file.preview}
          className="conv-rich-input__thumb-img"
        />
      ) : (
        <div className="conv-rich-input__non-media">
          <span>
            {file.name.length > 20 ?
              `${file.name.substring(0, 10)}...` :
              `${file.name.split('.')[0]}`
            }
            <br />
            {`.${file.extension}`}
          </span>
        </div>
      )
      }
      <div className="conv-rich-input__thumb-close-icon" onClick={() => handleThumbClose(file.preview)}>
        <span>&times;</span>
      </div>
    </div>
  ))

  // emoji picker
  useEffect(() => {
    const handleEmojiOutClick = event => {
      const emojiPiker = document.querySelector('.emoji-mart')
      const emojiIconBtn = document.getElementById('emoji_icon_btn')
      if (!event.target.contains(emojiIconBtn) && !emojiPiker.contains(event.target)) {
        setIsEmojiPickerVisible(false)
      }
    }
    document.addEventListener('click', handleEmojiOutClick)

    return () => {
      document.removeEventListener('click', handleEmojiOutClick)
    }
  }, [])

  return (
    <div className="conv-chat__footer">
      <div className="" style={{ marginRight: '18.8px' }}>
        <div className="conv-chat__footer-user-pic">
          <CurrentUserPic />
        </div>
        <div className="conv-chat__footer-icon-attach">
          <IconButton
            onClick={open}
            imageSrc={iconAttach}
            imageSrcActive={iconAttachActive}
            active={false}
            style={{ width: '22.5px',height: '22.5px', marginRight: '0' }}
          />
        </div>
      </div>
      <div className="conv-rich-input__container">
        <section className=""  style={{ borderBottom: 'solid 0.8px #dedede' }}>
          <div {...getRootProps({ className: 'dropzone' })}>
            <input {...getInputProps()} />
            <Slate editor={editor} value={value} onChange={handleChange} >
              <Editable
                id="editable"
                // style={slatejsEditableStyle}
                className="conv-rich-input__slate-editable"
                placeholder="Start type"
                editor={editor}
                renderLeaf={renderLeaf}
                onKeyDown={handleKeyDown}
                onPaste={handlePaste}

                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck={false}
              />
            </Slate>
            <div
              className="conv-rich-input__textarea-wrapper"
            >
              <Textarea
                className="conv-rich-input__textarea"
                onChange={handleTextareaChange}
              />
            </div>
            {isDragEnter && (
              <div className="conv-rich-input__dnd">
                <span>Drag & Drop files here</span>
              </div>
            )}
          </div>
          <aside className="conv-rich-input__thumbs-container">
            {thumbs}
          </aside>
        </section>
        <div className="conv-rich-input__action-bar">
          <div>
            {_.map(marks, (value, key) => (
              <IconButton
                key={key}
                onClick={() => toggleMark(editor, key)}
                imageSrc={value[0]}
                imageSrcActive={value[1]}
                active={isMarkActive(editor, key)}
              />
            ))}
          </div>
          <div className="conv-rich-input__action-bar-right">
            <IconButton
              id="emoji_icon_btn"
              onClick={() => setIsEmojiPickerVisible(!isEmojiPickerVisible)}
              active={isEmojiPickerVisible}
              imageSrc={iconEmoji}
              imageSrcActive={iconEmojiActive}
              style={{ marginRight: '5px', width: '20px', height: '20px' }}
            />
            <IconButton
              onClick={open}
              imageSrc={iconAttach}
              imageSrcActive={iconAttachActive}
              active={false}
              style={{ width: '17.5px',height: '17.5px' }}
            />
            <button
              disabled={isTextEmpty && isFileEmpty}
              onClick={handleClick}
              className={(isTextEmpty && isFileEmpty) ? 'conv-rich-input__send-btn-inactive' : 'conv-rich-input__send-btn-active'}
            >
              <span>Send</span>
              <i className="conv-rich-input__send-btn-icon" style={{ backgroundImage: `url('${(isTextEmpty && isFileEmpty) ? iconRightArrowGrey : iconRightArrowWhite}')` }} />
            </button>
          </div>
        </div>
        <DetectMessage
          show={isEmailDetected}
          onClose={handleEmailDetectMessgeClose}
          containerStyle={{ bottom: '100px', right: '30px' }}
          titleStyle={{ color: '#ed1943' }}
          {...detectMsgTexts.email}
        />
        <DetectMessage
          show={isUnsupportedFileDetected}
          onClose={handleUnsupportedFileDetectMessageClose}
          containerStyle={{ bottom: '100px', right: '30px', height: '135px' }}
          titleStyle={{ color: '#ed1943' }}
          {...detectMsgTexts.unsupportedFileType}
        />
        {user.userType === 'client' && <DetectMessage
          show={isAttachDetected}
          onClose={handleAttachDetectMessgeClose}
          containerStyle={{ bottom: '67px', right: '30px', height: '136px' }}
          titleStyle={{ color: '#3e4042' }}
          {...detectMsgTexts.attach}
        />}
        <Picker
          style={{ position: 'absolute', bottom: '90px', right: '30px', visibility: isEmojiPickerVisible ? 'visible' : 'hidden' }}
          emoji="point_up"
          onSelect={handleEmojiSelect}
          title=""
          autoFocus={true}
        />
      </div>
      <div className="conv-chat__footer-send-btn-mobile">
        <button
          disabled={isTextEmpty && isTextMobileEmpty && isFileEmpty}
          onClick={handleClick}
          className={(isTextEmpty && isTextMobileEmpty && isFileEmpty) ? 'conv-rich-input__send-btn-inactive' : 'conv-rich-input__send-btn-active'}
        >
          <span>Send</span>
          <i className="conv-rich-input__send-btn-icon" style={{ backgroundImage: `url('${(isTextEmpty && isTextMobileEmpty && isFileEmpty) ? iconRightArrowGrey : iconRightArrowWhite}')` }} />
        </button>
      </div>
    </div>
  )
}

export default ConversationRichInput
