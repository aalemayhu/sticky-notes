const path = require('path')
const fs = require('fs')

const compiler = require('imba/dist/compiler.js')

let sourcePath = path.join(__dirname, 'sticky-notes.imba')

let imbaDist = fs.readFileSync('./node_modules/imba/dist/imba.js', 'utf-8').toString()
let code = fs.readFileSync(sourcePath, 'utf-8').toString()

let js = compiler.compile(code, {
  sourcePath: sourcePath,
  imbaPath: null,
  target: 'web',
  standalone: yes
}):js

let output = "{imbaDist}\n{js}"

fs.writeFileSync('./sticky-notes.js', output)
