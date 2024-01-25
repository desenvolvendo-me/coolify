const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    screens: {
      xl: '1440px',
      lg: '976px',
      md: '768px',
      sm: '480px'
    },
    extend: {
      colors: {
        coolify: {
          1: '#22A8E6',
          2: '#222CE6',
          3: '#226AE6',
          4: '#22E6E6',
          5: '#5622E6',
        },
      },
    },
  },
  plugins: [
    require('flowbite/plugin'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
}
