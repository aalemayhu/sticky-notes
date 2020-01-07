const fs = require('fs')

const compiler = require('imba/dist/compiler.js')

let imbaDist = fs.readFileSync('./node_modules/imba/dist/imba.js', 'utf-8').toString()
let code = fs.readFileSync('./sticky-notes.imba', 'utf-8').toString()

let js = compiler.compile(code, {
  sourcePath: "unknown",
  imbaPath: null,
  target: 'web'
}):js

let output = "{imbaDist}\n{js}"

fs.writeFileSync('./sticky-notes.js', output)
