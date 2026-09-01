---
name: Academic Play
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#424754'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#727785'
  outline-variant: '#c2c6d6'
  surface-tint: '#005ac2'
  primary: '#0058be'
  on-primary: '#ffffff'
  primary-container: '#2170e4'
  on-primary-container: '#fefcff'
  inverse-primary: '#adc6ff'
  secondary: '#795900'
  on-secondary: '#ffffff'
  secondary-container: '#ffc329'
  on-secondary-container: '#6f5100'
  tertiary: '#006947'
  on-tertiary: '#ffffff'
  tertiary-container: '#00855b'
  on-tertiary-container: '#f5fff6'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc6ff'
  on-primary-fixed: '#001a42'
  on-primary-fixed-variant: '#004395'
  secondary-fixed: '#ffdf9f'
  secondary-fixed-dim: '#f9bd22'
  on-secondary-fixed: '#261a00'
  on-secondary-fixed-variant: '#5c4300'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-xl:
    fontFamily: Quicksand
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-xl-mobile:
    fontFamily: Quicksand
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 36px
  headline-lg:
    fontFamily: Quicksand
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-md:
    fontFamily: Quicksand
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Nunito Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Nunito Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Nunito Sans
    fontSize: 14px
    fontWeight: '700'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-margin-mobile: 16px
  container-margin-desktop: 48px
  gutter: 24px
  touch-target-min: 44px
---

## Brand & Style
The design system is centered on "Focused Play"—a balance between the rigor of academic achievement and the joy of discovery. It targets a broad K-12 audience, necessitating a UI that feels accessible to younger children without appearing "babyish" to teenagers.

The style is a hybrid of **Minimalism** and **Tactile** design. It utilizes heavy whitespace to reduce cognitive load during quizzes, paired with soft, physically-inspired elements that respond to touch. The emotional goal is to evoke curiosity, safety, and a sense of accomplishment. Every interaction should feel supportive, clear, and energetic.

## Colors
The palette is designed to be high-energy yet stable.
- **Primary (Energetic Blue):** Used for core actions, branding, and active states. It represents trust and intelligence.
- **Secondary (Playful Yellow):** Used sparingly as an accent to draw attention to rewards, streaks, and "Level Up" moments.
- **Tertiary (Soft Mint):** Reserved for success states, correct answers, and progress completion.
- **Neutral:** A range of slate blues and greys used for secondary text and borders to maintain a soft, non-intimidating contrast.
- **Background:** A very light off-white/blue tint to reduce eye strain compared to pure white.

## Typography
Typography emphasizes legibility and friendliness. **Quicksand** is used for headlines to provide a distinct, rounded "storybook" feel that remains modern. **Nunito Sans** is used for body copy and UI labels because its rounded terminals maintain the friendly aesthetic while offering superior legibility for longer quiz questions and educational content. 

For the younger demographic, font sizes are slightly larger than standard enterprise apps to ensure ease of reading. Headlines use a tighter letter-spacing to appear more cohesive and "bold."

## Layout & Spacing
The design system employs a **fluid grid** with generous margins to create a "contained" and safe feel. 
- **Mobile:** A 4-column grid with 16px margins. Content is mostly stacked to prioritize focus on one question at a time.
- **Tablet/Desktop:** A 12-column grid. Sidebars are used for progress tracking and profile stats, keeping the central quiz area clear.

Spacing follows an 8px linear scale. Large internal padding (24px+) is preferred for cards and containers to give elements "room to breathe," which helps students with ADHD or visual processing challenges stay focused on the task at hand.

## Elevation & Depth
This design system uses **Tonal Layers** combined with **Ambient Shadows**. 
- **Depth Levels:** Most interactive elements (cards, buttons) sit on a "Level 1" shadow—a soft, wide-spread blur with a slight primary-color tint (e.g., a blue-tinted shadow for blue buttons) to keep the UI looking vibrant rather than muddy.
- **Active States:** When pressed, elements should visually "sink" (shadow decreases, element scales slightly down), mimicking physical buttons.
- **Surface Tiers:** Use subtle background fills (e.g., a very light mint for a "Correct" feedback card) rather than heavy borders to indicate different sections.

## Shapes
Shapes are unapologetically **Rounded**. This eliminates "sharpness" and creates a welcoming, safe environment for learning. 
- Standard components (Inputs, Small Cards) use `rounded-md` (0.5rem).
- Large containers and featured quiz cards use `rounded-lg` (1rem).
- Interactive buttons and chips use `rounded-xl` (1.5rem) or full pill-shapes to invite clicking.

## Components
- **Quiz Cards:** Large-format cards with 32px internal padding. They feature a subtle 1px border in a darker shade of the background color and a soft ambient shadow.
- **Buttons:** Primary buttons are tall (min 48px height) with bold Quicksand text. They use a solid fill with a 2px bottom "offset" border to create a 3D-pressable look.
- **Progress Indicators:** Horizontal bars with fully rounded end-caps. The track is a light neutral, while the fill is a vibrant gradient of Primary Blue or Tertiary Mint.
- **Option Selectors:** For multiple-choice questions, use large cards that change color and "pop" slightly in scale when selected.
- **AI Feedback Toasts:** Floating bubbles with a distinct icon and soft color-coded backgrounds (e.g., light blue for hints, light yellow for "Almost there!").
- **Avatars:** Always circular with a 2px vibrant border to denote the user's current level or rank.