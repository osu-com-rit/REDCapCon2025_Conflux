/**
 * REDCap Layout Switcher
 * Transforms form fields into Card or Grid layouts based on radio button selection
 * Integrates with Shazam form system
 */
document.addEventListener("DOMContentLoaded", function () {
    
    /**
     * Main callback function that runs before Shazam displays the form
     * This is where we transform the original markup into our layout system
     */
    Shazam.beforeDisplayCallback = function () {
        // Find the main container that holds all form fields
        const host = document.getElementById('edc-main-container');
        if (!host) return true; // Exit if container not found, let Shazam continue normally

        // Only process the form structure once to avoid duplicate transformations
        if (!host.classList.contains('edc-host')) {
            host.classList.add('edc-host'); // Mark as processed

            // Helper Functions
            // ================
            
            /**
             * Check if an element is a label element based on CSS classes
             * @param {Element} el - DOM element to check
             * @returns {boolean} - True if element has 'edc-label' class
             */
            const isLabelNode = (el) => {
                if (!el || el.nodeType !== 1) return false;
                const cls = el.className || "";
                return cls.includes("edc-label");
            };

            /**
             * Clean up label text by removing ':label' suffix
             * @param {string} t - Raw label text
             * @returns {string} - Cleaned label text
             */
            const cleanLabel = (t) => (t || "").replace(/:label\s*$/i, "").trim();

            /**
             * Extract field type from CSS classes (radio, checkbox, text, etc.)
             * @param {Element} el - DOM element to analyze
             * @returns {string} - Field type or 'field' as fallback
             */
            const typeFrom = (el) => ((el.className || "").match(/edc-(radio|checkbox|slider|text|notes)/) || [, 'field'])[1];

            // Structure Transformation
            // ========================

            // Get all child elements from the container
            const kids = Array.from(host.children);
            const pairs = []; // Will hold label/value pairs

            // Parse alternating label/value structure into pairs
            for (let i = 0; i < kids.length; i++) {
                const el = kids[i];
                if (isLabelNode(el)) {
                    const value = kids[i + 1]; // Next element should be the value
                    pairs.push({ 
                        type: typeFrom(el), 
                        labelEl: el, 
                        valueEl: value 
                    });
                    i++; // Skip the value element in next iteration
                }
            }

            // Create new structure with wrapper elements
            const frag = document.createDocumentFragment();
            pairs.forEach((p, index) => {
                // Create wrapper container for each field
                const item = document.createElement('div');
                item.className = 'edc-item';
                item.setAttribute('role', 'group'); // Accessibility: group related elements

                // Create label container
                const labelSlot = document.createElement('div');
                labelSlot.className = 'edc-label-slot';

                // Generate unique ID for accessibility linking
                const labelId = `edc-${p.type}-${Math.random().toString(36).slice(2, 8)}-lbl`;
                const labelSpan = document.createElement('span');
                labelSpan.id = labelId;
                labelSpan.textContent = cleanLabel(p.labelEl.textContent) || p.type;
                labelSlot.appendChild(labelSpan);

                // Create value container
                const valueSlot = document.createElement('div');
                valueSlot.className = 'edc-value-slot';

                // Move original elements into new structure
                if (p.valueEl) valueSlot.appendChild(p.valueEl);
                
                // Hide original label (keep for form functionality but don't display)
                p.labelEl.setAttribute('aria-hidden', 'true');
                p.labelEl.style.display = 'none';
                labelSlot.appendChild(p.labelEl);

                // Link label and content for screen readers
                item.setAttribute('aria-labelledby', labelId);
                item.append(labelSlot, valueSlot);
                frag.appendChild(item);
            });

            // Replace original content with new structured content
            host.innerHTML = '';
            host.appendChild(frag);
        }

        // Layout Switching Logic
        // ======================

        /**
         * Switch between Card and Grid layouts
         * @param {string} mode - Either 'card' or 'grid'
         */
        const setMode = (mode) => {
            // Remove existing layout classes
            host.classList.remove('mode-card', 'mode-grid');
            // Add new layout class
            host.classList.add(mode === 'grid' ? 'mode-grid' : 'mode-card');
        };

        // Initialize with Card layout as default
        setMode('card');

        // Event Handling for Layout Switching
        // ===================================

        // Find all demo_switcher radio buttons
        const demoSwitcherRadios = document.querySelectorAll('input[name="demo_switcher___radio"]');
        
        // Add change listeners to each radio button
        demoSwitcherRadios.forEach(radio => {
            // Prevent duplicate event listeners
            if (!radio.dataset.edcBound) {
                radio.addEventListener('change', function() {
                    if (this.checked) {
                        // Value '1' = Grid mode, Value '2' = Card mode
                        const mode = this.value === '1' ? 'grid' : 'card';
                        setMode(mode);
                    }
                });
                // Mark as having event listener attached
                radio.dataset.edcBound = '1';
            }
        });

        // Return true to allow Shazam to continue with its normal processing
        return true;
    };
});