# SupraWeb – E-commerce Browse Page

This Rails application implements a responsive "Browse All Products" experience for the Young Developer Power (Full-stack Track) curriculum. The page pulls catalog data straight from the public [Fake Store API](https://fakestoreapi.com/products) and renders it with Tailwind CSS to provide a clean, mobile-friendly layout without persisting anything in a local database.

The latest refresh introduces:
- A premium storefront theme with higher-contrast branding, animated hero modules, and flash-sale storytelling tuned for desktop and mobile shoppers.
- Thai/English language toggling, ensuring copy and placeholders adapt instantly for local customers.
- Lightweight flows for sign-in, a live dashboard with traffic/revenue counters, wallet top ups, and payment education—plus an interactive AI concierge mockup for quick Q&A.
- Recommendation rails and timed promotions that surface trending products drawn directly from the live API response.

## Why Ruby on Rails?

Ruby on Rails offers a productive full-stack environment with conventions that accelerate building real features. Controllers, views, and routing make it straightforward to consume external APIs, while the built-in view helpers (such as number formatting) and Hotwire defaults keep the front end fast. Using Rails also means deployment and future expansion (authentication, checkout flows, etc.) can build on a proven, batteries-included foundation.

## Getting Started

1. **Install dependencies**
   ```bash
   bundle install
   ```
   > If Bundler reports issues fetching gems (for example, a temporary network 403), retry the command once connectivity is restored.

2. **Start the development server**
   ```bash
   bin/rails server
   ```

3. Visit the app at [http://localhost:3000](http://localhost:3000) to browse products, explore recommendations, or test the interactive concierge widgets.

### Environment Notes
- This project uses Tailwind via the official CDN to keep the setup lightweight. You can switch to the `tailwindcss-rails` gem when you are ready for a fully offline build pipeline.
- Because data is fetched live from the Fake Store API on every request, the page will reflect any changes to that remote catalog immediately.
