// ===== Navbar scroll effect =====
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 50);
});

// ===== Mobile menu =====
const toggle = document.getElementById('mobileToggle');
const navLinks = document.getElementById('navLinks');

toggle.addEventListener('click', () => {
    navLinks.classList.toggle('open');
});

// Close menu on link click
navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => navLinks.classList.remove('open'));
});

// ===== Active nav link on scroll =====
const sections = document.querySelectorAll('section[id]');
window.addEventListener('scroll', () => {
    const scrollY = window.scrollY + 100;
    sections.forEach(sec => {
        const top = sec.offsetTop;
        const height = sec.offsetHeight;
        const id = sec.getAttribute('id');
        const link = navLinks.querySelector(`a[href="#${id}"]`);
        if (link) {
            link.classList.toggle('active', scrollY >= top && scrollY < top + height);
        }
    });
});

// ===== Form submit =====
const form = document.getElementById('contactForm');
form.addEventListener('submit', (e) => {
    e.preventDefault();
    const data = new FormData(form);
    const name = data.get('name');
    showToast(`感谢 ${name}！我们将在 24 小时内与您联系。`);
    form.reset();
});

// ===== Toast =====
function showToast(message) {
    let toast = document.querySelector('.toast');
    if (!toast) {
        toast = document.createElement('div');
        toast.className = 'toast';
        document.body.appendChild(toast);
    }
    toast.textContent = message;
    toast.classList.add('show');
    setTimeout(() => toast.classList.remove('show'), 3500);
}

// ===== Scroll reveal =====
const observerOptions = { threshold: 0.1, rootMargin: '0px 0px -50px 0px' };
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// ===== Category nav active on scroll =====
const catNav = document.getElementById('catNav');
const sidebarNav = document.getElementById('sidebarNav');
if (catNav || sidebarNav) {
    const catSections = document.querySelectorAll('.cat-section');
    const allCatLinks = document.querySelectorAll('#catNav a, #sidebarNav a');
    window.addEventListener('scroll', () => {
        let current = '';
        catSections.forEach(sec => {
            if (window.scrollY + 200 >= sec.offsetTop) {
                current = sec.getAttribute('id');
            }
        });
        allCatLinks.forEach(link => {
            link.classList.toggle('active', link.dataset.cat === current);
        });
    });
}

document.querySelectorAll('.product-card, .adv-card, .case-card, .step, .info-card, .detail-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(24px)';
    el.style.transition = 'opacity .6s ease, transform .6s ease';
    observer.observe(el);
});
