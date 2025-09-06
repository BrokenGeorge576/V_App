import { Controller } from "@hotwired/stimulus"
import * as pdfjsLib from "pdfjs-dist"

export default class extends Controller {
  static targets = ["canvas"]
  static values = { url: String }

  connect() {
    console.log("✅ PDF Viewer: Controlador Conectado.");
    pdfjsLib.GlobalWorkerOptions.workerSrc = `https://cdnjs.cloudflare.com/ajax/libs/pdf.js/${pdfjsLib.version}/pdf.worker.mjs`;
    this.loadPdf()
  }

  async loadPdf() {
    console.log("⏳ PDF Viewer: Iniciando la carga del PDF...");
    const url = this.urlValue
    const canvas = this.canvasTarget

    if (!canvas) {
      console.error("❌ PDF Viewer: ¡Error Fatal! No se encontró el target 'canvas'.");
      return;
    }

    console.log("📄 PDF Viewer: Cargando desde la URL:", url);
    const context = canvas.getContext('2d');

    try {
      const pdf = await pdfjsLib.getDocument(url).promise;
      console.log("📑 PDF Viewer: Documento cargado. Número de páginas:", pdf.numPages);

      const page = await pdf.getPage(1);
      console.log("📄 PDF Viewer: Página 1 obtenida.");

      const viewport = page.getViewport({ scale: 1.5 });
      console.log("🖼️ PDF Viewer: Viewport creado. Ajustando tamaño del canvas a:", viewport.width, "x", viewport.height);

      canvas.height = viewport.height;
      canvas.width = viewport.width;

      const renderContext = {
        canvasContext: context,
        viewport: viewport
      };

      console.log("🎨 PDF Viewer: A punto de renderizar la página en el canvas...");
      await page.render(renderContext).promise;
      console.log("✅ PDF Viewer: ¡Página renderizada con éxito!");

    } catch (error) {
      console.error("❌ PDF Viewer: Ocurrió un error durante el proceso.", error);
      context.fillStyle = "red";
      context.fillText("Ocurrió un error al renderizar el PDF.", 10, 50);
    }
  }
}