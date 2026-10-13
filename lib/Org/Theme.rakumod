unit class Theme;

#| site-wide look & feel, layered on top of the Air / Pico defaults
#| (Air gathers this into static/css/styles.scss when run with :scss)
method SCSS { q:to/END/;
    /* raku.org theme */

    :root {
      --pico-line-height: 1.5;
      --org-radius: 0.75rem;
    }

    body {
      overflow-x: clip;
    }

    /* header & nav */

    body > header.container {
      position: sticky;
      top: 0;
      z-index: 900;
      padding-block: 0.25rem;
    }

    body > header.container::before {
      content: "";
      position: absolute;
      z-index: -1;
      top: 0;
      bottom: 0;
      left: calc(50% - 50vw);
      width: 100vw;
      background: color-mix(in srgb, var(--pico-background-color) 88%, transparent);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid var(--pico-muted-border-color);
    }

    nav .logo {
      letter-spacing: -0.01em;

      &,
      &:hover {
        font-size: 1.35rem;
      }

      a {
        --pico-color: inherit;
      }
      img {
        width: 44px;
      }
    }

    nav .nav-links a {
      color: inherit;
      font-size: 0.95rem;
      font-weight: 500;
      text-decoration: none;
      text-transform: capitalize;

      &:hover {
        color: var(--pico-primary);
      }
    }

    nav .hamburger {
      font-size: 1.75rem;
      line-height: 1;
    }

    nav .menu {
      top: 100%;
      right: 0;
      margin: 0;
      background: var(--pico-card-background-color);
      border: 1px solid var(--pico-muted-border-color);
      border-radius: var(--org-radius);
      box-shadow: 0 0.75rem 2rem rgba(0, 0, 0, 0.18);

      a {
        color: inherit;
        text-decoration: none;
        text-transform: capitalize;
      }
    }

    /* page headings, hero & call to action */

    main h1 {
      letter-spacing: -0.02em;
    }

    main #background {
      opacity: 0.05;
    }

    main:not(:has(.hero)) #background {
      display: none;
    }

    .hero {
      padding-top: clamp(1.5rem, 5vw, 3.5rem);

      h1 {
        max-width: 40ch;
        margin-inline: auto;
        font-size: clamp(1.75rem, 4.2vw, 2.9rem);
        font-weight: 700;
        line-height: 1.15;
        text-wrap: balance;
      }
    }

    .cta {
      button {
        padding: 0.7rem 2.25rem;
        font-weight: 600;
      }
      p {
        margin: 0;
        color: var(--pico-muted-color);
        font-size: 0.875rem;
      }
    }

    /* cards */

    main article {
      border-color: var(--pico-form-element-border-color);
      border-radius: var(--org-radius);
      box-shadow: 0 1px 2px rgba(16, 24, 40, 0.04), 0 4px 12px rgba(16, 24, 40, 0.05);
    }

    /* text links & inline code */

    main a:not([role="button"]) {
      --pico-underline: color-mix(in srgb, var(--pico-primary) 30%, transparent);
      text-underline-offset: 0.2em;
    }

    main :not(pre) > code {
      padding: 0.1em 0.35em;
      border-radius: 0.3em;
      background: var(--pico-code-background-color);
      font-size: 0.875em;
    }

    /* home page feature tabs */

    .tabs {
      margin-top: 1.5rem;

      .tab-links {
        display: flex;
        flex-wrap: wrap;
        gap: 0.4rem;
        margin: 0 0 0.75rem;

        /* centred on small screens */
        @media (max-width: 768px) {
          justify-content: center;
        }
      }
      .tab-links > li {
        padding: 0;
      }
      .tab-links > li > a {
        margin: 0;
        padding: 0.3rem 0.85rem;
        border: 1px solid var(--pico-form-element-border-color);
        border-radius: 999px;
        color: var(--pico-muted-color);
        font-size: 0.875rem;
        font-weight: 500;

        &:hover {
          border-color: var(--pico-primary);
          color: var(--pico-primary);
        }
      }
      .tab-links > li.active > a {
        border: 1px solid var(--pico-primary-background);
        background: var(--pico-primary-background);
        color: var(--pico-primary-inverse);
      }

      .tab article {
        min-width: 0;
      }
      .tab article:has(.raku-code) {
        background: var(--pico-code-background-color);
      }

      /* fewer layout jumps when switching tabs (side by side layout only) */
      @media (min-width: 1025px) {
        .tab article {
          min-height: 20rem;
        }
      }
    }

    /* long-form tab content (install page) */

    .tab > div {
      > h1 {
        font-size: 1.5rem;
      }
      > h2 {
        margin-top: 2rem;
        font-size: 1.25rem;
      }
      > h3 {
        margin-top: 1.5rem;
        font-size: 1.05rem;
      }
      /* terminal style, to suit the (dark) highlight.js theme in use */
      > pre {
        border: 1px solid var(--pico-form-element-border-color);
        background: #0d1117;
      }
    }

    /* copy button: a quiet corner control that doesn't push the code down */

    .raku-code button.copy-code {
      position: absolute;
      top: 0;
      right: 0;
      float: none;
      width: auto;
      margin: 0;
      padding: 0.15rem 0.45rem;
      border: 1px solid var(--pico-form-element-border-color);
      background: var(--pico-card-background-color);
      color: var(--pico-muted-color);
      font-size: 0.9rem;
      line-height: 1.2;
      transition: opacity 0.15s;

      &:hover {
        border-color: var(--pico-primary);
        color: var(--pico-primary);
      }
    }

    /* sponsor & user logos */

    .logos {
      margin-top: 2rem;

      > p:first-child {
        margin-bottom: 0.5rem;
        color: var(--pico-muted-color);
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.08em;
        text-transform: uppercase;
      }
      /* the logo strip stays white in both themes (the logos need it) */
      > div {
        border: 1px solid var(--pico-form-element-border-color);
      }
    }

    /* dashboard panels (community, learn, tools, install) */

    main dashboard {
      gap: 1.5rem;
    }

    main dashboard > article {
      flex: 1 1 26rem;
      align-items: stretch;
      padding-left: var(--pico-block-spacing-horizontal) !important;
      padding-right: var(--pico-block-spacing-horizontal) !important;

      > header {
        margin: 0 0 1rem;
        padding: 0 0 0.75rem;
        background: none;
        border-bottom-color: var(--pico-muted-border-color);

        h3 {
          margin: 0;
          font-size: 1.15rem;
        }
      }
      > main {
        h3 {
          font-size: 1.1rem;
        }
        h4 {
          margin-bottom: 0.5rem;
          color: var(--pico-muted-color);
          font-size: 0.95rem;
        }
      }
    }

    /* footer */

    body > footer.container {
      padding-block: 1rem 2rem;
      text-align: center;
    }

    body > footer > p {
      margin-bottom: 0.35rem;
      color: var(--pico-muted-color);
      font-size: 0.8rem;
      font-style: normal;
    }

    /* Raku code highlighting on dark backgrounds */

    :root[data-theme="dark"] {
      --base-color-scalar: #7aa7f0;
      --base-color-array: #ff7b93;
      --base-color-hash: #3fd6c3;
      --base-color-code: #5db8f5;
      --base-color-keyword: #2fc4b2;
      --base-color-operator: #4ecb7b;
      --base-color-type: #ff6f8c;
      --base-color-routine: #6db7ea;
      --base-color-string: #5cbbe0;
      --base-color-string-delimiter: #58b5ee;
      --base-color-escape: #c9d1d9;
      --base-color-text: #d6d9de;
      --base-color-comment: #6fbf8c;
      --base-color-regex-special: #34c79a;
      --base-color-regex-literal: #e08a7a;
      --base-color-regex-delimiter: #e070e0;
      --base-color-doc-text: #52c795;
      --base-color-doc-markup: #ff6f8c;
    }
    END
}
