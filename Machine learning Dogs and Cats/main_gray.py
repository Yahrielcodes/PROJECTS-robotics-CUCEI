from tensorflow import keras
from keras.models import Sequential
from keras.layers import Dense, Flatten, Dropout, BatchNormalization
from keras.layers import Conv2D, MaxPooling2D
import matplotlib.pyplot as plt

train = keras.utils.image_dataset_from_directory('dogvscat/dataset/training_set/',
                                                 labels="inferred",
                                                 label_mode="binary",
                                                 color_mode="grayscale",
                                                 batch_size=32,
                                                 image_size=(50, 50))

test = keras.utils.image_dataset_from_directory('dogvscat/dataset/test_set/',
                                                labels="inferred",
                                                label_mode="binary",
                                                color_mode="grayscale",
                                                batch_size=32,
                                                image_size=(50, 50))

model = Sequential()

model.add(Conv2D(128, kernel_size=(3, 3), strides=(1, 1), padding='same', activation='relu', input_shape=(50, 50, 1)))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(64, kernel_size=(3, 3), strides=(1, 1), padding='same', activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Flatten())
model.add(Dense(256, activation='sigmoid'))  # Aumentar el tamaño de la capa densa
model.add(Dropout(0.5))  # Agregar Dropout para reducir el sobreajuste
model.add(Dense(128, activation='sigmoid'))
model.add(Dense(1, activation='sigmoid'))

model.compile(loss='binary_crossentropy', optimizer='Adam', metrics=['accuracy'])
model.summary()

hist = model.fit(train, batch_size=32, epochs=30, verbose=1, validation_data=test)

# Plot accuracy
plt.figure()
plt.plot(hist.history['accuracy'], lw=2)
plt.plot(hist.history['val_accuracy'], lw=2)
plt.title('Model Accuracy')
plt.ylabel('Accuracy')
plt.xlabel('Epoch')
plt.legend(['Training', 'Testing'], loc='upper left')
plt.show()

# Plot loss
plt.figure()
plt.plot(hist.history['loss'], lw=2)
plt.plot(hist.history['val_loss'], lw=2)
plt.title('Model Loss')
plt.ylabel('Loss')
plt.xlabel('Epoch')
plt.legend(['Training', 'Testing'], loc='upper left')
plt.show()

# Guardar el modelo entrenado
model.save('CNN_MASK.h5')
#model = keras.models.load_model('CNN_Model_MNIST.h5')



######################### INFORMACION ADICIONAL ######################################################

# image_dataset_from_directory
# labels: Either "inferred" (labels are generated from the directory structure), 
#         None (no labels), or a list/tuple of integer labels of the same size 
#         as the number of image files found in the directory. 
# label_mode: String describing the encoding of labels. Options are:
#             'categorical' means that the labels are encoded as a categorical vector (e.g. for categorical_crossentropy loss).
#             'binary' means that the labels (there can be only 2) are encoded as float32 scalars with values 0 or 1 (e.g. for binary_crossentropy).
# color_mode: One of "grayscale", "rgb", "rgba". Default: "rgb". Whether the images will be converted to have 1, 3, or 4 channels.
# batch_size: Size of the batches of data. Default: 32. If None, the data will not be batched (the dataset will yield individual samples).
# image_size: Size to resize images to after they are read from disk, specified as (height, width).

# Dropout layer: Dropout is a simple  and powerful regularization 
# technique. Randomly selected neurons are ignored during training.

# BatchNormalization layer: Batch normalization applies a transformation 
# that maintains the mean output close to 0 and the output standard 
# deviation close to 1.

# Padding: one of "valid" or "same" (case-insensitive). 
# "valid" means no padding. "same" results in padding with zeros 
# evenly to the left/right or up/down of the input. When padding="same" and strides=1, 
# the output has the same size as the input.

# Available activations
# relu function - ReLU activation: max(x, 0)
# sigmoid function - sigmoid(x) = 1 / (1 + exp(-x))
# softplus function - softplus(x) = log(exp(x) + 1)
# softsign function - softsign(x) = x / (abs(x) + 1)
# tanh function - tanh(x) = sinh(x)/cosh(x) = ((exp(x) - exp(-x))/(exp(x) + exp(-x)))
# selu function - if x > 0: return scale * x, if x < 0: return scale * alpha * (exp(x) - 1)
# elu function - The exponential linear unit (ELU) with alpha > 0 is: x if x > 0 and alpha * (exp(x) - 1) if x < 0

# Available optimizers
# SGD
# RMSprop
# Adam
# AdamW
# Adadelta
# Adagrad
# Adamax
# Adafactor
# Nadam# Ftrl
