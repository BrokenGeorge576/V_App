# Pin npm packages by running ./bin/importmap

# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Pines para PDF.js desde el CDN
pin "pdfjs-dist", to: "https://ga.jspm.io/npm:pdfjs-dist@4.4.168/build/pdf.mjs"
pin "pdfjs-dist/build/pdf.worker.mjs", to: "https://ga.jspm.io/npm:pdfjs-dist@4.4.168/build/pdf.worker.mjs"
