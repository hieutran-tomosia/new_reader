const { environment } = require('@rails/webpacker')
const webpack = require('webpack');

const { join } = require('path');
const { source_path: sourcePath, static_assets_extensions: fileExtensions } = require('@rails/webpacker/package/config');

fileConfig = {
  test: new RegExp(`(${fileExtensions.join('|')})$`, 'i'),
  use: [
    {
      loader: 'file-loader',
      options: {
        name(file) {
          if (file.includes(sourcePath)) {
            return '[path][name]-[hash].[ext]'
          }
          return '[folder]/[name]-[hash:8].[ext]'
        },
        context: join(sourcePath)
      }
    }
  ]
};

erbLoader = {
  test: /\.js\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: [{
    loader: 'rails-erb-loader',
    options: {
      runner: (/^win/.test(process.platform) ? 'ruby ' : '') + 'bin/rails runner'
    }
  }]
};

environment.loaders.prepend('file', fileConfig);
environment.loaders.append('erb', erbLoader);
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
);

console.log(`NODE ENVIRONMENT: ${process.env.NODE_ENV}`)
module.exports = environment;
