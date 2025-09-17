# REDCap Layout Switcher

A dynamic form layout system for REDCap that transforms standard form fields into responsive Card and Grid layouts.

## Overview

This system integrates with REDCap's Shazam form rendering engine to provide two distinct layout modes:
- **Card Layout**: Responsive card-based layout ideal for surveys and data entry
- **Grid Layout**: Traditional form-style two-column layout for efficient data review

## Files Structure

```
├── rc_demo.html          # HTML structure and demo switcher
├── rc_demo.js            # JavaScript transformation logic
├── rc_demo.css           # Bootstrap-integrated styling
└── loader_config.json    # REDCap Conflux configuration
```

## Features

### Layout Modes
- **Card Mode**: Responsive grid of cards (default)
  - Auto-fit columns with 280px minimum width
  - Vertical label/input stacking
  - Enhanced visual hierarchy with colored accent borders
  
- **Grid Mode**: Traditional form layout
  - Two-column structure (220px labels + flexible inputs)
  - Horizontal label/input alignment
  - Compact spacing for efficiency

### Visual Features
- **Field Type Color Coding**: Subtle left border colors differentiate field types
  - Radio: Soft green (`#d4edda`)
  - Checkbox: Soft yellow (`#fff3cd`)
  - Text: Soft blue (`#cce7ff`)
  - Notes: Soft pink (`#f8d7da`)
- **Bootstrap Integration**: Consistent spacing, colors, and component patterns
- **Smooth Interactions**: Hover effects and transitions
- **Mobile Responsive**: Single-column layout on screens < 640px

## Installation

### REDCap Integration
1. Place all files in a folder in your REDCap Conflux directory
2. Configure `loader_config.json` with your field specifications

## HTML Structure

The system expects alternating label/value pairs with specific CSS classes:

```html
<div id="edc-main-container">
    <div class="edc-radio edc-label shazam">field_name:label</div>
    <div class="edc-radio shazam">field_name</div>
    <div class="edc-checkbox edc-label shazam">field_name_2:label</div>
    <div class="edc-checkbox shazam">field_name_2</div>
</div>
```

## JavaScript

### Core Functions

#### Helper Functions
- `isLabelNode(el)`: Identifies label elements
- `cleanLabel(text)`: Removes `:label` suffixes
- `typeFrom(el)`: Extracts field type from CSS classes
- `setMode(mode)`: Switches between 'card' and 'grid' layouts

### Event Handling
The system listens for changes on radio buttons with `name="demo_switcher___radio"`:
- Value `"1"` = Grid layout
- Value `"2"` = Card layout

## CSS Architecture

### Bootstrap Integration
Uses Bootstrap 5 conventions:
- Spacing: `1rem`, `0.5rem`, `0.75rem`
- Colors: `#0d6efd` (primary), `#dc3545` (danger)
- Breakpoints: `640px` (sm equivalent)
- Component patterns: Cards, buttons, form controls

### Key CSS Classes
- `.edc-host`: Main container with CSS Grid
- `.edc-item`: Individual field wrapper
- `.edc-label-slot`: Label container
- `.edc-value-slot`: Input container
- `.mode-card`: Card layout styling
- `.mode-grid`: Grid layout styling

### Responsive Design
```css
@media (max-width: 640px) {
    #edc-main-container.mode-grid .edc-item {
        grid-template-columns: 1fr; /* Single column on mobile */
    }
}
```

## Browser Support

- **Modern Browsers**: Full support (Chrome 60+, Firefox 60+, Safari 12+)
- **CSS Grid**: Required (supported in all target browsers)
- **ES6 Features**: Arrow functions, const/let, template literals
- **Mobile**: iOS 12+, Android 7+

## Performance Considerations

- **One-time Processing**: Structure transformation occurs only once
- **Event Delegation**: Minimal event listeners
- **CSS Transitions**: Limited to visual properties only
- **Memory Efficient**: Uses DocumentFragment for DOM manipulation

## Troubleshooting

### Common Issues
1. **Layout not switching**: Check if `demo_switcher___radio` elements exist
2. **Styling conflicts**: Ensure CSS specificity with `!important` where needed
3. **Mobile layout issues**: Check viewport meta tag and media queries

### Debug Mode
Enable console logging by adding:
```javascript
console.log('Processing pairs:', pairs);
console.log('Demo switcher radios found:', demoSwitcherRadios.length);
```

## REDCap Specific Notes

### Field Requirements
- Fields must have `edc-label` and field type classes (`edc-radio`, `edc-checkbox`, etc.)
- Demo switcher must use REDCap's radio button naming convention
- Shazam integration required for form functionality

### Conflux Configuration
The `loader_config.json` file defines:
```json
{
  "description": "REDCapCon 2025 Conflux Demo",
  "fields": [
    {
      "field_name": "shazam_demo",
      "html": "rc_demo.html",
      "javascript": "rc_demo.js", 
      "css": "rc_demo.css"
    }
  ]
}
```

## Customization

### Adding New Field Types
1. Add CSS class pattern to `typeFrom()` function
2. Create corresponding CSS styling rules
3. Add color coding border if desired

### Modifying Layouts
- **Card Layout**: Adjust `grid-template-columns` in `.mode-card`
- **Grid Layout**: Modify column widths in `.mode-grid .edc-item`
- **Breakpoints**: Update media query values

### Color Themes
To customize:
1. Update CSS custom properties
2. Verify contrast ratios at [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
3. Test with screen readers

## Contributing

When modifying this system:
1. Maintain WCAG 2.1 AA compliance
2. Test across target browsers
3. Verify REDCap/Shazam integration

