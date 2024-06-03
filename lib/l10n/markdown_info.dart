class MarkdownInfo {
  static const String en = """
# PhoToText

### Machine Learning for Text Recognition, Language Identification and On-Device Translation

---

**PhoToText** allows you to recognize text in an image, detect its language, and dynamically translate it between more than 50 languages.

How it works:

1. Select a language to translate (by default, the application detects the system language).

2. Select an image with some text, from the camera or from a file in the gallery.

3. And click on the button to start the process.

---

# Google's Machine learning Kit

**PhoToText** uses some plugins to access the *Google Machine Learning Kit* for mobile devices. Although they run through Google's native APIs, these plugins are open source and are not sponsored or maintained by Google.

The *Google ML Kit* APIs used for image processing and natural language analysis are *Text recognition v2*, *Language identification*, and *Translation*.

## Text recognition

![card-text_recognition_720.png](assets/card-text_recognition_720.png)

This API recognizes text in many languages ​​and multiple alphabets, and analyzes its structure and language in real time.

The application supports character recognition from the Latin, Chinese, Devanagari, Japanese, and Korean alphabets. Within the recognized languages, there are 3 levels of support:

+ Fully supported languages: 37.

+ Languages ​​in experimental status: 16.

+ *Mapped* languages: 122.

The list of supported languages ​​can be found at [Text recognition v2: supported languages](https://developers.google.com/ml-kit/vision/text-recognition/v2/languages).

## Language identification

![card-language_id_720.png](assets/card-language_id_720.png)

It has broad language support, identifying over a hundred different languages.

The list of supported languages ​​can be found at [ML Kit language identification: supported languages](https://developers.google.com/ml-kit/language/identification/langid-support).

## Translation

![card-translation_720.png](assets/card-translation_720.png)

Broad language support, with dynamic translation models that run on the device and do not require sending the text to a remote server.

This plugin uses the Cloud Translation API (automatic translations from Google Translate). This on-device translation is intended for informal and simple translations, so its fidelity may be affected in complex texts or with less tested languages.

The list of supported languages ​​can be found at [ML Kit translation: supported languages](https://developers.google.com/ml-kit/language/translation/translation-language-support).

""";

  static const String es = """
# PhoToText

### Machine Learning for Text Recognition, Language Identification and On-Device Translation

---

**PhoToText** permite reconocer el texto en una imagen, detectar su idioma y traducirlo de forma dinámica entre más de 50 idiomas.

Funcionamiento:

1. Selecciona un idioma para traducir (por defecto, la aplicación detecta el idioma del sistema).

2. Selecciona una imagen con algún texto, desde la cámara o desde un archivo de la galería.

3. Y pulsa sobre el botón para iniciar el proceso.

---

# Google's Machine learning Kit

**PhoToText** utiliza algunos complementos para acceder al *Kit de Aprendizaje Automático de Google* para dispositivos móviles. Aunque se ejecutan mediante las API nativas de Google, estos complementos están desarrollados con código abierto y no están patrocinados ni mantenidos por Google.

Las API del *Kit ML de Google* utilizadas para procesamiento de imágenes y análisis del lenguage natural son *Text recognition v2*, *Language identification* y *Translation*.

## Reconocimiento de texto

![card-text_recognition_720.png](assets/card-text_recognition_720.png)

Esta API reconoce texto en muchos idiomas y varios alfabetos, y analiza su estructura e idioma en tiempo real.

La aplicación admite el reconocimiento de caracteres de los alfabetos latino, chino, devanagarí, japonés y coreano. 
Dentro de los idiomas reconocidos, hay 3 niveles de compatibilidad:

+ Idiomas totalmente soportados: 37.

+ Idiomas en estado experimental: 16.

+ Idiomas *mapeados*: 122.

La lista de los lenguajes admitidos se puede encontrar en [Text recognition v2: supported languages](https://developers.google.com/ml-kit/vision/text-recognition/v2/languages).

## Identificación de idiomas

![card-language_id_720.png](assets/card-language_id_720.png)

Tiene una amplia compatibilidad de idiomas, identificando más de cien idiomas diferentes.

La lista de los lenguajes admitidos se puede encontrar en [ML Kit language identification: supported languages](https://developers.google.com/ml-kit/language/identification/langid-support).

## Traducción

![card-translation_720.png](assets/card-translation_720.png)

Amplia compatibilidad de idiomas, con modelos dinámicos de traducción que se ejecutan en el dispositivo y no requieren enviar el texto a un servidor remoto.

Este complemento utiliza la API de Cloud Translation (traducciones automáticas de Google Traductor). Esta traducción integrada en el dispositivo está pensada para traducciones informales y simples, por lo que su fidelidad puede verse afectada en textos complejos o con idiomas menos testados.

La lista de los lenguajes admitidos se puede encontrar en [ML Kit translation: supported languages](https://developers.google.com/ml-kit/language/translation/translation-language-support).

""";
}
