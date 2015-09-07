title: 'Exporting Node.JS modules in Babel 6.x'
type: random
lang: en
date: 2016-05-10 03:33:51
tags:
---

Since the major updates on BabelJS on version 6 the entire transpiler requires the setup of plugins to convert code back to ES5. There's one caveat for Node.JS modules when exporting values using the ES6 module syntax.

<!-- more -->

When you have a module with a default export, like the example below, the `default` value [won't be exported anymore](https://phabricator.babeljs.io/T2212), so you end up with a module that does not work with Node.JS as expected:

```
// example.js

export default 42;

```

The code above will be turned into ES5, resulting in:

```
"use strict";

Object.defineProperty(exports, "__esModule", { value: true });

exports.default = 42;

```

As you can see, the `exports` binding will have a `default` value assigned to it, but nothing else. Users of Node.JS modules would expect the default value to exported when you require it with the CommonJS syntax: `var x = require('example.js');`

However, that's not the case. To fix this, use [this module](https://www.npmjs.com/package/babel-plugin-add-module-exports) and you're good to go.

This module will restore the old behaviour, adding this line back to transpiled code:

```
// ...

module.exports = exports['default'];
```

Fin.