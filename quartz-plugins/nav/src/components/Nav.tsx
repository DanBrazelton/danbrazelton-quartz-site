import type {
  QuartzComponent,
  QuartzComponentConstructor,
  QuartzComponentProps,
} from "@quartz-community/types"

function classNames(...classes: (string | undefined)[]): string {
  return classes.filter(Boolean).join(" ")
}

// Hand-picked top-level navigation links.
const NAV_LINKS: [string, string][] = [
  ["Home", "/"],
  ["Kitchen", "/kitchen/recipes"],
  ["Field Notes", "/field-notes"],
  ["Contact", "/contact"],
]

const Nav: QuartzComponent = ({ displayClass }: QuartzComponentProps) => {
  return (
    <nav class={classNames(displayClass, "dbz-nav")} aria-label="Primary">
      <ul class="dbz-nav-list">
        {NAV_LINKS.map(([label, href]) => (
          <li class="dbz-nav-item">
            <a class="dbz-nav-link" href={href}>
              {label}
            </a>
          </li>
        ))}
      </ul>
    </nav>
  )
}

Nav.css = `
.dbz-nav {
  width: 100%;
  margin: 0 0 1.5rem 0;
  border-bottom: 1px solid var(--lightgray);
}
.dbz-nav-list {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem 1.25rem;
  margin: 0;
  padding: 0 0 0.6rem 0;
}
.dbz-nav-item { margin: 0; padding: 0; }
.dbz-nav-link {
  font-family: var(--headerFont, var(--titleFont));
  font-weight: 600;
  font-size: 1rem;
  color: var(--dark);
  text-decoration: none;
  padding: 0.2rem 0;
  border-bottom: 2px solid transparent;
  transition: color 0.15s ease, border-color 0.15s ease;
}
.dbz-nav-link:hover {
  color: var(--secondary);
  border-bottom-color: var(--secondary);
}
`

export default (() => Nav) satisfies QuartzComponentConstructor
