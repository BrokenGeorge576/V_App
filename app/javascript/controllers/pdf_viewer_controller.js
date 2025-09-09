import { Controller } from "@hotwired/stimulus"
import { getDocument, GlobalWorkerOptions } from "pdfjs-dist"

GlobalWorkerOptions.workerSrc = "https://ga.jspm.io/npm:pdfjs-dist@4.4.168/build/pdf.worker.mjs"

export default class extends Controller {
  static targets = ["container"]
  static values = {
    url: String,
  }

  connect() {
    this.loadPdf()
  }

  async loadPdf() {
    if (!this.hasUrlValue) {
      return;
    }

    this.containerTarget.innerHTML = `<p class="text-muted p-5">Cargando PDF...</p>`

    try {
      const pdf = await getDocument(this.urlValue).promise;
      const numPages = pdf.numPages;

      this.containerTarget.innerHTML = "" 
      const containerWidth = this.element.clientWidth;

      for (let pageNum = 1; pageNum <= numPages; pageNum++) {
        const page = await pdf.getPage(pageNum);
        
        const viewport = page.getViewport({ scale: 1 });
        const scale = containerWidth / viewport.width;
        const scaledViewport = page.getViewport({ scale: scale });

        const canvas = document.createElement("canvas");
        canvas.style.display = "block";
        canvas.style.maxWidth = "100%"; 
        canvas.style.height = "auto";
        if (pageNum < numPages) {
          canvas.style.marginBottom = "10px"; 
        }

        const context = canvas.getContext('2d');
        canvas.height = scaledViewport.height;
        canvas.width = scaledViewport.width;

        this.containerTarget.appendChild(canvas);
        
        const renderContext = {
          canvasContext: context,
          viewport: scaledViewport
        };
        await page.render(renderContext).promise;
      }

    } catch (error) {
      console.error("PDF Viewer: Ocurrió un error al cargar el PDF.", error);
      this.containerTarget.innerHTML = `<p class="text-danger p-5">Error al cargar el PDF.</p>`;
    }
  }
}