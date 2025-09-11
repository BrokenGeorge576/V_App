# Vicky 1.0: Tu Gestor de Archivos Inteligente con IA

Vicky es una aplicación web construida con Ruby on Rails 7 que reinventa la gestión de archivos personales. No solo te permite organizar y visualizar tus documentos, sino que ahora puedes **"chatear" con ellos**. Gracias a su chatbot integrado con IA, puedes hacer preguntas, pedir resúmenes y extraer información clave de tus archivos de forma conversacional.

[![Mira el video](https://raw.githubusercontent.com/BrokenGeorge576/V_App/main/VApp.png)](https://raw.githubusercontent.com/BrokenGeorge576/V_App/main/V_App1_0.mp4)

## ✨ Características Principales

  * **Chatbot Inteligente**: Interactúa directamente con tus documentos. Haz preguntas en lenguaje natural sobre el contenido de un archivo y obtén respuestas precisas y contextualizadas, generadas por un modelo de lenguaje avanzado a través de la API de Groq.
  * **Extracción de Contenido**: El chatbot puede "leer" el contenido de múltiples tipos de archivo, incluyendo PDF, `.txt`, `.md`, y archivos de código como `.rb`, `.js`, entre otros.
  * **Escaneo y Gestión de Archivos**: Añade archivos fácilmente desde tu sistema local. Vicky almacena sus metadatos y te permite gestionarlos desde una interfaz limpia y centralizada.
  * **Organización Avanzada**:
      * **Temas**: Crea, edita y asigna múltiples temas a tus archivos para categorizarlos.
      * **Favoritos**: Marca archivos importantes para acceder a ellos rápidamente.
      * **Notas**: Añade notas personales a cada archivo.
  * **Búsqueda y Filtrado**: Encuentra lo que necesitas al instante con filtros por nombre, tipo de archivo, tema o favoritos.
  * **Visor de Documentos Integrado**:
      * **PDF**: Visualizador avanzado basado en PDF.js que renderiza documentos completos con scroll vertical.
      * **Imágenes**: Soporte para formatos comunes (JPG, PNG, GIF, etc.).
      * **Texto y Código**: Previsualización de archivos de texto plano y código con formato.

## 🛠️ Stack Tecnológico

  * **Backend**: Ruby on Rails 7
  * **Base de Datos**: PostgreSQL
  * **Frontend**:
      * Hotwire (Turbo Drive + Stimulus.js)
      * `importmap-rails` para dependencias de JavaScript
      * PDF.js para la renderización de PDFs
  * **Inteligencia Artificial**:
      * **Groq API** como proveedor del modelo de lenguaje (Llama 3).
      * **HTTParty** para las solicitudes a la API.
  * **Procesamiento de Archivos**:
      * **`pdf-reader`** para la extracción de texto de archivos PDF.
  * **Estilos**: Bootstrap y SASS.
  * **Lenguaje de Vistas**: Slim.

## 🚀 Instalación y Puesta en Marcha

Sigue estos pasos para configurar el entorno de desarrollo local.

**Prerrequisitos:**

![](https://github.com/BrokenGeorge576/V_App/blob/main/Animation%20Sticker%20GIF%20by%20The%20Ethereans.gif) 

  * Ruby (versión 3.1.1 o superior)
  * Bundler
  * PostgreSQL
  * Una clave de API de [Groq](https://groq.com/)

**Pasos:**

1.  **Clona el repositorio:**

    ```bash
    git clone https://github.com/BrokenGeorge576/V_App
    cd V_App
    ```

2.  **Instala las dependencias:**

    ```bash
    bundle install
    ```

3.  **Configura las credenciales:**
    La aplicación necesita una clave de API para conectarse al servicio de Groq. Ejecuta el siguiente comando para editar el archivo de credenciales de Rails:

    ```bash
    bin/rails credentials:edit
    ```

    Y añade tu clave de la siguiente manera:

    ```yaml
    groq:
      api_key: tu_clave_secreta_de_groq_aqui
    ```

    Guarda y cierra el editor.

4.  **Configura la base de datos:**
    Asegúrate de que tu archivo `config/database.yml` tenga las credenciales correctas para tu instancia de PostgreSQL. Luego, crea y migra la base de datos:

    ```bash
    rails db:create
    rails db:migrate
    ```

5.  **Inicia el servidor:**

    ```bash
    rails server
    ```

    La aplicación estará disponible en `http://localhost:3000`.

## 📖 Uso de la Aplicación

1.  **Escanear Archivos**: Haz clic en el botón "Escanear Archivos" para seleccionar y añadir documentos desde tu explorador de archivos.
2.  **Ver Detalles**: Haz clic en cualquier archivo de la lista para ir a la vista de detalles.
3.  **Interactuar con el Chatbot**:
      * En la vista de detalles, encontrarás la interfaz del chatbot.
      * Escribe una pregunta sobre el contenido del documento (ej: "¿Cuál es el punto principal de este texto?", "¿Qué tecnologías se mencionan?").
      * Presiona Enter para recibir una respuesta de Vicky, la asistente de IA.
4.  **Organizar**: En la misma vista, puedes marcar el archivo como favorito, añadirle notas o asignarle temas para una mejor organización.
