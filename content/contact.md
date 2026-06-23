---
publish: true
title: Contact
created: 2026-06-23T13:31:31.103Z
modified: 2026-06-23T14:44:49.156Z
---

# Contact

A note here reaches me directly — a role, a problem worth solving, or a conversation about food or radio.

<form class="contact-form" action="/api/contact" method="POST">
  <label class="contact-field">
    <span>Name</span>
    <input type="text" name="name" autocomplete="name" required>
  </label>
  <label class="contact-field">
    <span>Email</span>
    <input type="email" name="email" autocomplete="email" required>
  </label>
  <label class="contact-field">
    <span>Message</span>
    <textarea name="message" rows="6" required></textarea>
  </label>
  <input class="contact-hp" type="text" name="company" tabindex="-1" autocomplete="off" aria-hidden="true">
  <button class="contact-send" type="submit">Send</button>
</form>

[Linkedin](https://www.linkedin.com/in/dan-brazelton/)
[Youtube](https://www.youtube.com/@danbrazelton)

---

title: Contact
publish: true
-------------

# Contact

<form class="contact-form" action="/api/contact" method="POST">
  <label class="contact-field" style="display: block; margin-bottom: 15px;">
    <span style="display: block; margin-bottom: 5px;">Name</span>
    <input type="text" name="name" autocomplete="name" required>
  </label>

  <label class="contact-field" style="display: block; margin-bottom: 15px;">
    <span style="display: block; margin-bottom: 5px;">Email</span>
    <input type="email" name="email" autocomplete="email" required>
  </label>

  <label class="contact-field" style="display: block; margin-bottom: 15px;">
    <span style="display: block; margin-bottom: 5px;">Message</span>
    <textarea name="message" rows="6" required></textarea>
  </label>

  <input class="contact-hp" type="text" name="company" tabindex="-1" autocomplete="off" aria-hidden="true" style="display: none;">

<button class="contact-send" type="submit" style="margin-top: 10px;">Send</button>

</form>

<br>

[Linkedin](https://www.linkedin.com/in/dan-brazelton/)
[Youtube](https://www.youtube.com/@danbrazelton)
