// Language Switcher
document.addEventListener('DOMContentLoaded', function() {
    const langTabs = document.querySelectorAll('.lang-tab');
    const body = document.body;
    
    langTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const lang = this.getAttribute('data-lang');
            
            // Update active state
            langTabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            
            // Update body data-lang attribute
            body.setAttribute('data-lang', lang);
            
            // Toggle hero descriptions
            const heroDescEN = document.querySelectorAll('.hero-desc-en, .hero-desc-sub-en');
            const heroDescJP = document.querySelectorAll('.hero-desc-jp, .hero-desc-sub-jp');
            
            if (lang === 'EN') {
                heroDescEN.forEach(el => el.style.display = 'block');
                heroDescJP.forEach(el => el.style.display = 'none');
            } else {
                heroDescEN.forEach(el => el.style.display = 'none');
                heroDescJP.forEach(el => el.style.display = 'block');
            }
        });
    });
    
    // Mobile Menu Toggle
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.querySelector('.nav-menu');
    
    if (hamburger) {
        hamburger.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            hamburger.classList.toggle('active');
        });
    }
    
    // Smooth Scroll for Navigation Links
    const navLinks = document.querySelectorAll('.nav-link, .btn-primary, .btn-secondary, .footer-links a');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            
            if (href && href.startsWith('#')) {
                e.preventDefault();
                const targetId = href.substring(1);
                const targetElement = document.getElementById(targetId);
                
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                    
                    // Close mobile menu if open
                    if (navMenu.classList.contains('active')) {
                        navMenu.classList.remove('active');
                        hamburger.classList.remove('active');
                    }
                }
            }
        });
    });
    
    // Active Navigation Highlighting on Scroll
    const sections = document.querySelectorAll('section[id], header[id]');
    const navLinksAll = document.querySelectorAll('.nav-link');
    
    function highlightNav() {
        let current = '';
        const scrollPos = window.pageYOffset + 100;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            
            if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
                current = section.getAttribute('id');
            }
        });
        
        navLinksAll.forEach(link => {
            link.classList.remove('active');
            const href = link.getAttribute('href');
            if (href === '#' + current || (current === '' && href === '#')) {
                link.classList.add('active');
            }
        });
    }
    
    window.addEventListener('scroll', highlightNav);
    highlightNav(); // Initial call
    
    // Navbar scroll effect (optional - adds shadow on scroll)
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.3)';
        } else {
            navbar.style.boxShadow = 'none';
        }
    });
});

// Mobile Menu CSS (add dynamically for hamburger menu)
const style = document.createElement('style');
style.textContent = `
    @media (max-width: 768px) {
        .nav-menu {
            position: fixed;
            left: -100%;
            top: 73px;
            flex-direction: column;
            background: rgba(10, 22, 40, 0.98);
            width: 100%;
            text-align: center;
            transition: 0.3s;
            box-shadow: 0 10px 27px rgba(0, 0, 0, 0.05);
            padding: 20px 0;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-menu.active {
            left: 0;
        }

        .nav-menu a {
            padding: 12px 0;
        }

        .hamburger.active span:nth-child(2) {
            opacity: 0;
        }

        .hamburger.active span:nth-child(1) {
            transform: translateY(7px) rotate(45deg);
        }

        .hamburger.active span:nth-child(3) {
            transform: translateY(-7px) rotate(-45deg);
        }
    }
`;
document.head.appendChild(style);
