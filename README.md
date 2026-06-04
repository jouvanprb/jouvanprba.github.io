# Jouvan's Blog
Hi! I'm Jouvan. I write about things I learn, build, and think about in tech. This blog is where I document my journey and share knowledge with others.
Personal blog by me — sharing insights on software engineering, DevOps automation, cloud infrastructure, and modern tech.
Built with [Jekyll](https://jekyllrb.com/) and the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme, heavily customized.
---

## Tech Stack

- **Jekyll** — Static site generator
- **Chirpy Theme** by [cotes2020](https://github.com/cotes2020)
- **Firebase Hosting** — Production
- **GitHub Actions** — CI/CD
- **Docker Compose** — Local development

---

## Development

`docker compose up` — runs locally with auto-reload.

---

## Deployment

Push to `main` triggers GitHub Actions:

1. Checkout → Setup Ruby & Node
2. Install dependencies → Build Jekyll
3. Deploy to Firebase Hosting

Workflow: `.github/workflows/deploy.yml`

---

## Credits

Based on the [Chirpy Jekyll Theme](https://github.com/cotes2020/jekyll-theme-chirpy) by [cotes2020](https://github.com/cotes2020).

---

## License

MIT