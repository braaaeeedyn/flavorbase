/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Flavorbase Theme Colors
        'deep-cream': {
          dark: '#02343F',
          light: '#F0EDCC',
        },
        'royal-coral': {
          dark: '#00539C',
          light: '#EEA47F',
        },
        'soft-olive': {
          dark: '#1A2417',
          light: '#ABC8A2',
        },
        'peach-crush': {
          dark: '#E84F5E',
          light: '#FCDFC5',
        },
        'dark-whisper': {
          dark: '#4B421B',
          light: '#D7EAE2',
        },
        'burgundy-sand': {
          dark: '#5C0E14',
          light: '#F0E193',
        },
        'cloudy-ocean': {
          dark: '#2772A0',
          light: '#CCDDEA',
        },
        'satin-lush': {
          dark: '#730000',
          light: '#C5A880',
        },
        'silver-silk': {
          dark: '#50222D',
          light: '#C4C3D0',
        },
        'cold-lake': {
          dark: '#1A2037',
          light: '#3A97D4',
        },
        'pale-bubblegum': {
          dark: '#EA738D',
          light: '#C8CE91',
        },
        'sweet-toffee': {
          dark: '#755139',
          light: '#F2EDD7',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
