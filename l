import React, { useState, useEffect, useRef } from 'react';
import { Menu, X, ChevronRight, ArrowRight } from 'lucide-react';

const JSLWebsite = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const [activeSection, setActiveSection] = useState('home');
  const [scrollProgress, setScrollProgress] = useState(0);
  const [visibleSections, setVisibleSections] = useState({});
  const observerRef = useRef(null);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
      
      // Calculate scroll progress
      const windowHeight = window.innerHeight;
      const documentHeight = document.documentElement.scrollHeight;
      const scrollTop = window.scrollY;
      const progress = (scrollTop / (documentHeight - windowHeight)) * 100;
      setScrollProgress(progress);
    };
    
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    observerRef.current = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          setVisibleSections((prev) => ({
            ...prev,
            [entry.target.id]: entry.isIntersecting,
          }));
        });
      },
      { threshold: 0.1, rootMargin: '-50px' }
    );

    document.querySelectorAll('section[id]').forEach((section) => {
      observerRef.current.observe(section);
    });

    return () => {
      if (observerRef.current) {
        observerRef.current.disconnect();
      }
    };
  }, []);

  const projects = [
    {
      title: 'Residential Excellence',
      category: 'Precision',
      image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80'
    },
    {
      title: 'Commercial Innovation',
      category: 'Innovation',
      image: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&q=80'
    },
    {
      title: 'Structural Integrity',
      category: 'Authorized',
      image: 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=800&q=80'
    }
  ];

  return (
    <div className="bg-gray-50 text-gray-900 font-sans overflow-x-hidden">
      {/* Scroll Progress Bar */}
      <div className="fixed top-0 left-0 w-full h-1 bg-gray-200 z-50">
        <div 
          className="h-full bg-gradient-to-r from-cyan-600 to-cyan-400 transition-all duration-300 ease-out"
          style={{ width: `${scrollProgress}%` }}
        ></div>
      </div>

      {/* Cursor Follower */}
      <style>{`
        @keyframes fadeInUp {
          from {
            opacity: 0;
            transform: translateY(30px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        @keyframes fadeInLeft {
          from {
            opacity: 0;
            transform: translateX(-30px);
          }
          to {
            opacity: 1;
            transform: translateX(0);
          }
        }
        
        @keyframes fadeInRight {
          from {
            opacity: 0;
            transform: translateX(30px);
          }
          to {
            opacity: 1;
            transform: translateX(0);
          }
        }
        
        @keyframes scaleIn {
          from {
            opacity: 0;
            transform: scale(0.9);
          }
          to {
            opacity: 1;
            transform: scale(1);
          }
        }
        
        .animate-fade-in-up {
          animation: fadeInUp 0.8s ease-out forwards;
        }
        
        .animate-fade-in-left {
          animation: fadeInLeft 0.8s ease-out forwards;
        }
        
        .animate-fade-in-right {
          animation: fadeInRight 0.8s ease-out forwards;
        }
        
        .animate-scale-in {
          animation: scaleIn 0.8s ease-out forwards;
        }
        
        .stagger-1 { animation-delay: 0.1s; opacity: 0; }
        .stagger-2 { animation-delay: 0.2s; opacity: 0; }
        .stagger-3 { animation-delay: 0.3s; opacity: 0; }
        .stagger-4 { animation-delay: 0.4s; opacity: 0; }
        .stagger-5 { animation-delay: 0.5s; opacity: 0; }
        .stagger-6 { animation-delay: 0.6s; opacity: 0; }
        
        .parallax {
          transition: transform 0.3s ease-out;
        }
        
        .smooth-hover {
          transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
      `}</style>
      {/* Navigation */}
      <nav className={`fixed w-full z-40 transition-all duration-500 ${scrolled ? 'bg-white/95 backdrop-blur-md shadow-lg py-4' : 'bg-transparent py-6'}`}>
        <div className="max-w-7xl mx-auto px-6 flex justify-between items-center">
          <div className="flex items-center transform transition-transform duration-500 hover:scale-105">
            <div className="flex flex-col">
              <span className="text-2xl font-light tracking-tight text-gray-900">JSL Consulting</span>
              <span className="text-xs tracking-[0.3em] text-gray-500 uppercase">Structural Engineers</span>
            </div>
          </div>
          
          <div className="hidden md:flex items-center space-x-12">
            <a href="#home" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 relative group">
              Home
              <span className="absolute -bottom-1 left-0 w-0 h-px bg-cyan-600 group-hover:w-full transition-all duration-300"></span>
            </a>
            <a href="#services" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 relative group">
              Services
              <span className="absolute -bottom-1 left-0 w-0 h-px bg-cyan-600 group-hover:w-full transition-all duration-300"></span>
            </a>
            <a href="#projects" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 relative group">
              Projects
              <span className="absolute -bottom-1 left-0 w-0 h-px bg-cyan-600 group-hover:w-full transition-all duration-300"></span>
            </a>
            <a href="#about" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 relative group">
              About
              <span className="absolute -bottom-1 left-0 w-0 h-px bg-cyan-600 group-hover:w-full transition-all duration-300"></span>
            </a>
            <a href="#contact" className="px-6 py-2 border border-gray-900 text-sm tracking-wider uppercase hover:bg-gray-900 hover:text-white transition-all duration-300 hover:scale-105 hover:shadow-lg">Contact</a>
          </div>

          <button className="md:hidden transition-transform duration-300 hover:scale-110" onClick={() => setIsMenuOpen(!isMenuOpen)}>
            {isMenuOpen ? <X /> : <Menu />}
          </button>
        </div>

        {/* Mobile Menu */}
        {isMenuOpen && (
          <div className="md:hidden bg-white/95 backdrop-blur-md border-t animate-fade-in-up">
            <div className="flex flex-col space-y-4 px-6 py-8">
              <a href="#home" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 hover:translate-x-2">Home</a>
              <a href="#services" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 hover:translate-x-2">Services</a>
              <a href="#projects" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 hover:translate-x-2">Projects</a>
              <a href="#about" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 hover:translate-x-2">About</a>
              <a href="#contact" className="text-sm tracking-wider uppercase hover:text-cyan-600 transition-all duration-300 hover:translate-x-2">Contact</a>
            </div>
          </div>
        )}
      </nav>

      {/* Hero Section */}
      <section id="home" className="relative h-screen flex items-center justify-center bg-gray-100 overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-gray-50 to-gray-200 opacity-50"></div>
        
        {/* Animated background elements */}
        <div className="absolute inset-0 overflow-hidden">
          <div className="absolute top-20 left-20 w-64 h-64 bg-cyan-600/5 rounded-full blur-3xl animate-pulse"></div>
          <div className="absolute bottom-20 right-20 w-96 h-96 bg-cyan-600/5 rounded-full blur-3xl animate-pulse" style={{ animationDelay: '1s' }}></div>
        </div>
        
        <div className="relative z-10 text-center max-w-4xl mx-auto px-6">
          <div className="mb-8 animate-fade-in-up">
            <div className="w-24 h-1 bg-cyan-600 mx-auto mb-12"></div>
          </div>
          <h1 className="text-5xl md:text-7xl font-light mb-6 tracking-tight leading-tight animate-fade-in-up stagger-1">
            Redefining Minimalism<br />
            <span className="text-4xl md:text-6xl text-gray-600">In Every Space</span>
          </h1>
          <p className="text-lg md:text-xl text-gray-600 mb-12 font-light tracking-wide max-w-2xl mx-auto animate-fade-in-up stagger-2">
            Precision engineering meets architectural elegance
          </p>
          <a href="#contact" className="inline-flex items-center space-x-2 px-8 py-4 bg-gray-900 text-white text-sm tracking-widest uppercase hover:bg-cyan-600 transition-all duration-500 hover:scale-105 hover:shadow-2xl animate-fade-in-up stagger-3">
            <span>Start Your Project</span>
            <ArrowRight size={18} className="transition-transform duration-300 group-hover:translate-x-2" />
          </a>
        </div>
        
        <div className="absolute bottom-12 left-1/2 transform -translate-x-1/2 animate-fade-in-up stagger-4">
          <div className="w-px h-16 bg-gray-400 animate-pulse"></div>
        </div>
      </section>

      {/* Services Section */}
      <section id="services" className="py-32 bg-white">
        <div className="max-w-7xl mx-auto px-6">
          <div className={`grid md:grid-cols-2 gap-16 items-center mb-24 transition-all duration-1000 ${visibleSections.services ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>
            <div className="animate-fade-in-left">
              <span className="text-sm tracking-[0.3em] text-cyan-600 uppercase mb-4 block">Our Expertise</span>
              <h2 className="text-4xl md:text-5xl font-light mb-6 leading-tight">Structural Solutions<br />Built on Excellence</h2>
              <div className="w-20 h-1 bg-cyan-600 mb-6 transform origin-left transition-transform duration-700 hover:scale-x-150"></div>
              <p className="text-gray-600 text-lg font-light leading-relaxed">
                We deliver precision-engineered structural solutions that seamlessly blend technical excellence with architectural vision.
              </p>
            </div>
            <div className="h-96 bg-gradient-to-br from-gray-100 to-gray-200 animate-fade-in-right transform transition-transform duration-500 hover:scale-105 hover:shadow-2xl"></div>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            {[
              { title: 'Precision', desc: 'Meticulous attention to every structural detail, ensuring perfection in design and execution.' },
              { title: 'Innovation', desc: 'Forward-thinking solutions that push the boundaries of structural engineering.' },
              { title: 'Authorized', desc: 'Fully certified and compliant with all industry standards and regulations.' }
            ].map((service, idx) => (
              <div key={idx} className={`group animate-fade-in-up stagger-${idx + 1}`}>
                <div className="border border-gray-200 p-8 hover:border-cyan-600 transition-all duration-500 h-full flex flex-col hover:shadow-2xl hover:-translate-y-2 bg-white">
                  <div className="text-6xl font-light text-gray-200 mb-4 group-hover:text-cyan-600 transition-all duration-500 transform group-hover:scale-110">0{idx + 1}</div>
                  <h3 className="text-2xl font-light mb-4 tracking-wide">{service.title}</h3>
                  <p className="text-gray-600 font-light leading-relaxed flex-grow">{service.desc}</p>
                  <div className="mt-6 flex items-center text-sm tracking-wider uppercase text-cyan-600">
                    <span>Learn More</span>
                    <ChevronRight size={16} className="ml-2 transform transition-transform duration-300 group-hover:translate-x-2" />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Projects Section */}
      <section id="projects" className="py-32 bg-gray-50">
        <div className="max-w-7xl mx-auto px-6">
          <div className={`text-center mb-20 transition-all duration-1000 ${visibleSections.projects ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>
            <span className="text-sm tracking-[0.3em] text-cyan-600 uppercase mb-4 block">Portfolio</span>
            <h2 className="text-4xl md:text-5xl font-light mb-6">Selected Works</h2>
            <div className="w-20 h-1 bg-cyan-600 mx-auto transform origin-center transition-transform duration-700 hover:scale-x-150"></div>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            {projects.map((project, idx) => (
              <div key={idx} className={`group cursor-pointer animate-scale-in stagger-${idx + 1}`}>
                <div className="relative overflow-hidden mb-4 h-80 rounded-sm">
                  <img 
                    src={project.image} 
                    alt={project.title}
                    className="w-full h-full object-cover transition-all duration-700 group-hover:scale-110 group-hover:rotate-1"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500"></div>
                  <div className="absolute inset-0 border-2 border-white/0 group-hover:border-white/20 transition-all duration-500 m-4"></div>
                  <div className="absolute bottom-6 left-6 text-white transform translate-y-8 group-hover:translate-y-0 transition-all duration-500 opacity-0 group-hover:opacity-100">
                    <span className="text-xs tracking-widest uppercase block mb-2">{project.category}</span>
                    <div className="w-12 h-px bg-cyan-400"></div>
                  </div>
                </div>
                <h3 className="text-xl font-light tracking-wide mb-2 transition-colors duration-300 group-hover:text-cyan-600">{project.title}</h3>
                <div className="w-12 h-px bg-cyan-600 transform scale-0 group-hover:scale-100 transition-transform duration-500 origin-left"></div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* About Section */}
      <section id="about" className="py-32 bg-white overflow-hidden">
        <div className="max-w-7xl mx-auto px-6">
          <div className={`grid md:grid-cols-2 gap-16 items-center transition-all duration-1000 ${visibleSections.about ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-10'}`}>
            <div className="h-96 bg-gradient-to-br from-cyan-100 to-gray-100 transform transition-all duration-700 hover:scale-105 hover:rotate-1 hover:shadow-2xl relative group overflow-hidden">
              <div className="absolute inset-0 bg-gradient-to-tr from-cyan-600/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-700"></div>
            </div>
            <div>
              <span className="text-sm tracking-[0.3em] text-cyan-600 uppercase mb-4 block">About Us</span>
              <h2 className="text-4xl md:text-5xl font-light mb-6 leading-tight">Engineering Tomorrow's Landmarks</h2>
              <div className="w-20 h-1 bg-cyan-600 mb-8 transform origin-left transition-transform duration-700 hover:scale-x-150"></div>
              <p className="text-gray-600 text-lg font-light leading-relaxed mb-6">
                JSL Consulting brings together decades of structural engineering expertise with a commitment to architectural excellence. Our team transforms complex structural challenges into elegant, efficient solutions.
              </p>
              <p className="text-gray-600 text-lg font-light leading-relaxed mb-8">
                From residential masterpieces to commercial innovations, we ensure every project stands as a testament to precision, safety, and timeless design.
              </p>
              <div className="flex space-x-12 text-center">
                {[
                  { num: '500+', label: 'Projects' },
                  { num: '25+', label: 'Years' },
                  { num: '100%', label: 'Satisfaction' }
                ].map((stat, idx) => (
                  <div key={idx} className={`group animate-fade-in-up stagger-${idx + 4}`}>
                    <div className="text-4xl font-light text-cyan-600 mb-2 transition-all duration-300 group-hover:scale-110 group-hover:text-cyan-500">{stat.num}</div>
                    <div className="text-sm tracking-wider uppercase text-gray-500">{stat.label}</div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Contact Section */}
      <section id="contact" className="py-32 bg-gray-900 text-white relative overflow-hidden">
        {/* Animated background */}
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-0 left-0 w-96 h-96 bg-cyan-600 rounded-full blur-3xl animate-pulse"></div>
          <div className="absolute bottom-0 right-0 w-96 h-96 bg-cyan-600 rounded-full blur-3xl animate-pulse" style={{ animationDelay: '2s' }}></div>
        </div>
        
        <div className={`max-w-4xl mx-auto px-6 text-center relative z-10 transition-all duration-1000 ${visibleSections.contact ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>
          <span className="text-sm tracking-[0.3em] text-cyan-400 uppercase mb-4 block animate-fade-in-up">Get In Touch</span>
          <h2 className="text-4xl md:text-5xl font-light mb-6 animate-fade-in-up stagger-1">Let's Build Something Extraordinary</h2>
          <div className="w-20 h-1 bg-cyan-600 mx-auto mb-12 animate-fade-in-up stagger-2 transform origin-center transition-transform duration-700 hover:scale-x-150"></div>
          <p className="text-gray-400 text-lg font-light mb-12 max-w-2xl mx-auto animate-fade-in-up stagger-3">
            Ready to bring your vision to life? Contact us to discuss how our structural engineering expertise can elevate your next project.
          </p>
          
          <div className="grid md:grid-cols-3 gap-8 mb-12">
            {[
              { label: 'Email', value: 'info@jslconsulting.com', href: 'mailto:info@jslconsulting.com' },
              { label: 'Phone', value: '+44 1234 567890', href: 'tel:+441234567890' },
              { label: 'Location', value: 'Bolton, England', href: null }
            ].map((contact, idx) => (
              <div key={idx} className={`group animate-fade-in-up stagger-${idx + 4}`}>
                <div className="text-sm tracking-widest uppercase text-gray-500 mb-2">{contact.label}</div>
                {contact.href ? (
                  <a href={contact.href} className="hover:text-cyan-400 transition-all duration-300 inline-block transform hover:scale-105">{contact.value}</a>
                ) : (
                  <span>{contact.value}</span>
                )}
              </div>
            ))}
          </div>

          <a href="mailto:info@jslconsulting.com" className="inline-flex items-center space-x-2 px-8 py-4 border border-white text-sm tracking-widest uppercase hover:bg-white hover:text-gray-900 transition-all duration-500 hover:scale-105 hover:shadow-2xl group animate-fade-in-up stagger-6">
            <span>Start Your Project</span>
            <ArrowRight size={18} className="transform transition-transform duration-300 group-hover:translate-x-2" />
          </a>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-black text-gray-400 py-12">
        <div className="max-w-7xl mx-auto px-6 text-center">
          <div className="mb-6 transform transition-all duration-500 hover:scale-105">
            <span className="text-xl font-light tracking-tight text-white">JSL Consulting</span>
            <div className="text-xs tracking-[0.3em] uppercase mt-1">Structural Engineers</div>
          </div>
          <div className="w-12 h-px bg-gray-700 mx-auto mb-6 transform origin-center transition-transform duration-500 hover:scale-x-150 hover:bg-cyan-600"></div>
          <p className="text-sm">© 2025 JSL Consulting. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
};

export default JSLWebsite;
