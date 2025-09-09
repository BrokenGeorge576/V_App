# Vicky App: Gestor de Archivos Inteligente

Vicky App es una aplicación web construida con Ruby on Rails 7 diseñada para ser un gestor y visualizador de archivos personales. La aplicación permite escanear archivos desde el sistema de archivos local, almacenar sus metadatos en una base de datos y ofrecer una interfaz limpia para buscar, filtrar y previsualizar los archivos.

## Características Principales

  * **Escaneo de Archivos desde la UI**: Permite a los usuarios seleccionar múltiples archivos desde su explorador local para que sean procesados y añadidos a la base de datos a través de un botón interactivo.
  * **Filtrado y Búsqueda Avanzada**: La interfaz principal cuenta con filtros para buscar archivos por nombre, tipo de archivo, y temas asignados. También se puede filtrar para mostrar únicamente los archivos marcados como favoritos.
  * **Vista Previa Integrada**: Al seleccionar un archivo, se muestra una vista detallada con una previsualización del contenido. El sistema soporta:
      * **Imágenes**: Muestra los formatos más comunes (JPG, PNG, GIF, SVG, etc.).
      * **Archivos de Texto**: Renderiza el contenido de archivos de código (`.rb`, `.js`, `.css`), texto plano (`.txt`), y más.
      * **PDFs**: Incluye un visor de PDFs avanzado basado en **PDF.js** que renderiza todas las páginas del documento, ajustándose al tamaño del contenedor y permitiendo el scroll vertical.
  * **Gestión de Metadatos**: El usuario puede añadir **notas personales** a cada archivo, marcarlo como **favorito** y asignarle múltiples **temas** para una mejor organización.
  * **Gestión de Temas**: Una sección dedicada para crear, editar y eliminar los temas que se pueden asignar a los archivos.

## 🚀 Próximas Funcionalidades

La característica principal y más potente de Vicky App está en camino. ¡Muy pronto, podrás interactuar con un **chatbot inteligente** directamente desde la vista de detalles de cada archivo\!

Podrás "chatear" con tus documentos, hacer preguntas sobre su contenido, pedir resúmenes y obtener información clave de forma conversacional. Esta funcionalidad transformará la manera en que interactúas con tus archivos.

**¡Mantente atento a las actualizaciones\!**

## Stack Tecnológico

  * **Backend**: Ruby on Rails 7
  * **Base de Datos**: PostgreSQL
  * **Frontend**:
      * Hotwire (Turbo Drive + Stimulus.js) para una experiencia de usuario rápida y reactiva.
      * `importmap-rails` para la gestión de dependencias de JavaScript.
      * **PDF.js** para la renderización de documentos PDF.
  * **Estilos**: Bootstrap y SASS para un diseño limpio y responsivo.
  * **Lenguaje de Vistas**: Slim.

## Instalación y Puesta en Marcha

Sigue estos pasos para configurar el entorno de desarrollo local.

**Prerrequisitos:**

  * Ruby (versión 3.1.1)
  * Bundler
  * PostgreSQL

**Pasos:**

1.  **Clona el repositorio:**

    git clone https://github.com/BrokenGeorge576/V_App
    cd v_app

2.  **Instala las dependencias:**

    bundle install

3.  **Configura la base de datos:**
    Asegúrate de que tu archivo `config/database.yml` tenga las credenciales correctas para tu instancia de PostgreSQL. Luego, crea y migra la base de datos:

    rails db:create
    rails db:migrate

4.  **Crea temas iniciales (opcional):**
    Puedes crear algunos temas desde la consola de Rails para empezar a organizar tus archivos:

    rails c
    Theme.create(name: "Trabajo")
    Theme.create(name: "Personal")
    exit

5.  **Inicia el servidor:**

    rails server

    La aplicación estará disponible en `http://localhost:3000`.

## Uso de la Aplicación

1.  **Escanear Archivos**: Haz clic en el botón azul "Escanear Archivos" en la esquina inferior izquierda. Se abrirá el explorador de archivos de tu sistema. Selecciona uno o varios archivos para añadirlos a la aplicación.
2.  **Filtrar Archivos**: Utiliza los campos en la barra de navegación superior para buscar por nombre, tipo de archivo o tema. Marca la casilla "Favoritos" para ver solo los archivos que hayas marcado.
3.  **Ver Detalles**: Haz clic en el nombre de cualquier archivo de la lista para ir a la vista de detalles.
4.  **Interactuar con un Archivo**: En la vista de detalles, puedes:
      * Ver la previsualización del contenido.
      * Marcar/desmarcar el archivo como favorito.
      * Añadir notas personales.
      * Asignar o quitar temas.
      * Guardar los cambios con el botón "Guardar Cambios".
