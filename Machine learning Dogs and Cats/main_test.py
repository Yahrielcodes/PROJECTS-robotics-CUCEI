from tensorflow import keras
import cv2 as cv
import numpy as np

# Cargar el modelo
lista = ['Gato', 'Perro']
model = keras.models.load_model('CNN_MASK2.h5')

# Leer la imagen de prueba
patron = cv.imread('prueba5.jpg')

# Convertir la imagen a escala de grises
gray_img = cv.cvtColor(patron, cv.COLOR_BGR2GRAY)

# Redimensionar la imagen al tamaño esperado por el modelo
img_resized = cv.resize(gray_img, (50, 50))  # Redimensiona a 50x50 píxeles


img_input = img_resized.reshape(-1, 50, 50, 1) / 255.0


pred = model.predict(img_input)


label = lista[int(pred[0, 0] > 0.5)]


img_display = np.ones_like(patron) * 200 # Fondo blanco


text_size, _ = cv.getTextSize(label, cv.FONT_HERSHEY_SIMPLEX, 1, 2)


box_coords = ((50, 50 + 5), (50 + text_size[0] + 5, 50 - text_size[1] - 5))

#  cuadro de fondo blanco
cv.rectangle(patron, box_coords[0], box_coords[1], (255, 255, 255), -1) 
#cv2.putText(img, texto, ubicacion, font, tamañoLetra, colorLetra, grosorLetra, bottomLeftOrigin = False)

# Mostrar la imagen con la etiqueta predicha y el cuadro de fondo
cv.putText(patron, label, (50, 50), cv.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 0), 2) 
cv.imshow('frame', patron)


cv.waitKey(0)
cv.destroyAllWindows()
