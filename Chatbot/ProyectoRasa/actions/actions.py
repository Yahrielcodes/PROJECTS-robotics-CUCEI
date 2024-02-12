# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List
#
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import cv2
import numpy as np


class Botar_catalago(Action):
#
    def name(self) -> Text:
         return "action_catalago"
#
    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
         opcion=tracker.get_slot('tipo_de_uso')
         gama=tracker.get_slot('GAMA')

         palabrasA =[]

         if(opcion=="carretera"):
             if(gama=="gama alta"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_carretera_gama_Alta.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama media"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_carretera_gama_media.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama baja"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_carretera_gama_baja.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
         if(opcion=="ciudad"):
             if(gama=="gama alta"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_ciudad_gama_alta.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama media"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_ciudad_alta_gama_media.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama baja"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\A_ciudad_gama_baja.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
         dispatcher.utter_message(text="catalago enviado")
         dispatcher.utter_message(tex="en caso de que la imagen no te aparezca es que tuviste un error ortografico trata de escribir mejor")

         return []
class Botar_catalago_otro(Action):
#para camionetas
    def name(self) -> Text:
         return "action_catalago_dos"
#
    def run(self, dispatcher: CollectingDispatcher,
             tracker: Tracker,
             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
         opcion=tracker.get_slot('tipo_de_uso')
         gama=tracker.get_slot('GAMA')

         palabrasA =[]

         if(opcion=="carretera"):
             if(gama=="gama alta"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_carretera_gama_Alta.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama media"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_carretera_gama_media.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama baja"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_carretera_gama_baja.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
         if(opcion=="ciudad"):
             if(gama=="gama alta"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_ciudad_gama_alta.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama media"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_ciudad_gama_media.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama baja"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\C_ciudad_gama_baja.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
         if(opcion=="montaña"):
             if(gama=="gama alta"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\montana_alta_gama_alta.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama media"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\montana_alta_gama_media.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
             if(gama=="gama baja"):
                 im = cv2.imread('C:\\Users\\Equipo\\Desktop\\ProyectoRasa\\catalagos\\montana_alta_gama_baja.jpg')
                 cv2.imshow('image0',im)
                 cv2.waitKey(0)
         dispatcher.utter_message(text="catalago enviado")
         dispatcher.utter_message(tex="en caso de que la imagen no te aparezca es que tuviste un error ortografico trata de escribir mejor")

         return []
