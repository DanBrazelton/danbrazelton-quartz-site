---
publish: true
title: Contact
created: 2026-06-23T13:31:31.103Z
modified: 2026-06-23T14:26:13.786Z
---

# Contact

---

title: Contact
publish: true
-------------

<div class="contact-wrapper">

  <header class="contact-header">
    <h1>Contact</h1>
    <p>Have a question or want to connect? Send me a message below.</p>
  </header>

  <form class="contact-form" action="/api/contact" method="POST">

```
<div class="form-group">
  <label for="name">Name</label>
  <input type="text" id="name" name="name" autocomplete="name" placeholder="Jane Doe" required>
</div>

<div class="form-group">
  <label for="email">Email</label>
  <input type="email" id="email" name="email" autocomplete="email" placeholder="jane@example.com" required>
</div>

<div class="form-group">
  <label for="message">Message</label>
  <textarea id="message" name="message" rows="5" placeholder="How can I help you?" required></textarea>
</div>

<!-- Honeypot to prevent spam -->
<input class="contact-hp" type="text" name="company" tabindex="-1" autocomplete="off" aria-hidden="true" style="display: none;">

<button class="btn-submit" type="submit">Send Message</button>
```

  </form>

  <hr class="contact-divider" />

  <footer class="contact-socials">
    <p>Or find me elsewhere:</p>
    <nav class="social-links">
      <a href="https://www.linkedin.com/in/dan-brazelton/" target="_blank" rel="noopener noreferrer" class="social-btn linkedin">LinkedIn</a>
      <a href="https://www.youtube.com/@danbrazelton" target="_blank" rel="noopener noreferrer" class="social-btn youtube">YouTube</a>
    </nav>
  </footer>

</div>
