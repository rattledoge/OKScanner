from xml.dom.minidom import Text
from flask import Blueprint, request, jsonify
import requests
import io
import pytesseract
from PIL import Image

scan = Blueprint('scan', __name__, url_prefix='/api/v1')

#for production
pytesseract.pytesseract.tesseract_cmd = (
    r"C:\Program Files\Tesseract-OCR\tesseract"
)


@scan.route('/scan_photo',methods=['POST'])
def scan_photo():
    language = request.form.get('language')
    source = request.form.get('source')
    
    ImageAPIUrl = 'https://freeimage.host/api/1/upload'
    ImageAPIparams = {'key': '6d207e02198a847aa98d0a2a901485a5', 'action': 'upload', 'format': 'txt'}
    ImageAPIdata = {'source' : source}
    responseImageAPI = requests.post(url=ImageAPIUrl, params= ImageAPIparams, data = ImageAPIdata)

    responsePhoto = requests.get(responseImageAPI.content)
    img = Image.open(io.BytesIO(responsePhoto.content))
    text = pytesseract.image_to_string(img,lang=language)
    return text