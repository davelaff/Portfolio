# Power Apps Vibe App — Playwright Skills Reference

A practical reference for building and testing Power Apps using vibe coding (AI-assisted development) and the Playwright extension.

---

## Table of Contents

1. [What Is a Power Apps Vibe App?](#1-what-is-a-power-apps-vibe-app)
2. [Prerequisites](#2-prerequisites)
3. [Core Power Apps Skills](#3-core-power-apps-skills)
4. [Playwright Extension Setup](#4-playwright-extension-setup)
5. [Vibe Coding Workflow](#5-vibe-coding-workflow)
6. [Writing Playwright Tests for Power Apps](#6-writing-playwright-tests-for-power-apps)
7. [Common Patterns & Recipes](#7-common-patterns--recipes)
8. [Troubleshooting](#8-troubleshooting)

---

## 1. What Is a Power Apps Vibe App?

A **vibe app** is an app built using AI-assisted (vibe) coding — you describe what you want in natural language, and an AI co-pilot generates the formulas, screens, and logic. Playwright is then used to automate testing of the resulting canvas app.

**Key tools in the stack:**

| Tool | Purpose |
|------|---------|
| Power Apps Studio | Canvas app builder |
| Copilot in Power Apps | AI formula and screen generation |
| VS Code Power Platform Tools | Local development and source control |
| Playwright (Test Engine) | Automated UI testing |
| Power Platform CLI (`pac`) | App packaging and deployment |

---

## 2. Prerequisites

### Accounts & Licenses
- Microsoft 365 or Power Apps Developer Plan (free at [aka.ms/powerappsdev](https://aka.ms/powerappsdev))
- Azure AD / Entra ID tenant

### Tools to Install
```bash
# Node.js (v18+)
node --version

# Power Platform CLI
npm install -g @microsoft/powerplatform-actions

# Or install pac via dotnet
dotnet tool install --global Microsoft.PowerApps.CLI.Tool

# Playwright
npm init playwright@latest
npx playwright install
```

### VS Code Extensions
- **Power Platform Tools** (`microsoft.powerplatform-vscode`)
- **Playwright Test for VS Code** (`ms-playwright.playwright`)

---

## 3. Core Power Apps Skills

### Canvas App Fundamentals
- **Screens**: `Navigate()`, `Back()`, screen transitions
- **Controls**: Gallery, Form, Button, Text Input, Dropdown, Date Picker
- **Data sources**: SharePoint, Dataverse, Excel, SQL, custom connectors
- **Collections**: `Collect()`, `ClearCollect()`, `UpdateIf()`, `RemoveIf()`
- **Variables**: `Set()` (global), `UpdateContext()` (local)

### Power Fx Essentials
```
// Filter a gallery
Filter(Employees, Department = "Engineering")

// Patch (create or update a record)
Patch(Employees, Defaults(Employees), {Name: txtName.Text, Role: drpRole.Selected.Value})

// If/Switch logic
If(UserRole = "Admin", Navigate(AdminScreen), Navigate(HomeScreen))

// LookUp
LookUp(Projects, ID = Gallery1.Selected.ID, ProjectName)
```

### Vibe Coding Prompts for Copilot
Use natural language in Power Apps Copilot to scaffold screens:
- *"Create a form to submit a new employee with Name, Department, and Start Date"*
- *"Add a gallery that shows all items where Status equals Pending"*
- *"Write a formula that patches the form to SharePoint and shows a success message"*

---

## 4. Playwright Extension Setup

### Install the Power Apps Test Engine
Microsoft's test engine wraps Playwright for canvas apps:

```bash
# Clone the test engine (or use npm package)
git clone https://github.com/microsoft/PowerApps-TestEngine
cd PowerApps-TestEngine
dotnet build

# Or use the npm wrapper
npm install @microsoft/powerplatform-playwright
```

### VS Code Playwright Extension
1. Install **Playwright Test for VS Code**
2. Open Command Palette → `Test: Install Playwright`
3. Configure `playwright.config.ts`:

```typescript
import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  use: {
    baseURL: 'https://apps.powerapps.com',
    headless: false,          // set true for CI
    screenshot: 'on-failure',
    video: 'retain-on-failure',
  },
});
```

### Authentication Setup
Power Apps requires authenticated sessions. Use `storageState` to persist login:

```bash
# Save auth state once
npx playwright codegen --save-storage=auth.json https://make.powerapps.com
```

```typescript
// playwright.config.ts
use: {
  storageState: 'auth.json',
}
```

---

## 5. Vibe Coding Workflow

```
1. DESCRIBE  →  Tell Copilot what screen or feature you need
2. GENERATE  →  Let Copilot scaffold the controls and formulas
3. REVIEW    →  Read and verify the generated Power Fx logic
4. REFINE    →  Iterate with follow-up prompts
5. EXPORT    →  Export app source via pac or VS Code extension
6. TEST      →  Write Playwright tests against the published app
```

### Typical Copilot Session
```
You:     "I need a screen where a manager can approve or reject 
          pending time-off requests from their team"

Copilot: [generates Gallery + Filter formula + Patch buttons]

You:     "Add a text field for rejection reason that only shows
          when Reject is clicked"

Copilot: [adds conditional visibility and UpdateContext formula]
```

---

## 6. Writing Playwright Tests for Power Apps

### Basic Page Object Pattern
```typescript
// tests/timeoff.spec.ts
import { test, expect } from '@playwright/test';

const APP_URL = 'https://apps.powerapps.com/play/<app-id>';

test.beforeEach(async ({ page }) => {
  await page.goto(APP_URL);
  await page.waitForSelector('[data-control-name="HomeScreen"]');
});

test('manager can approve a pending request', async ({ page }) => {
  // Navigate to approval screen
  await page.click('[data-control-name="btnApprovals"]');
  
  // Wait for gallery to load
  await page.waitForSelector('[data-control-name="galRequests"]');
  
  // Select first item
  await page.click('[data-control-name="galRequests"] [data-row-index="0"]');
  
  // Click approve
  await page.click('[data-control-name="btnApprove"]');
  
  // Assert success notification
  await expect(page.locator('[data-control-name="lblSuccess"]')).toBeVisible();
  await expect(page.locator('[data-control-name="lblSuccess"]')).toHaveText('Approved!');
});
```

### Locating Power Apps Controls
Power Apps controls render with `data-control-name` attributes matching the control name in Studio:

```typescript
// Button named "btnSubmit" in Power Apps Studio
page.locator('[data-control-name="btnSubmit"]')

// Text input named "txtEmail"
page.locator('[data-control-name="txtEmail"] input')

// Gallery named "galEmployees", first row
page.locator('[data-control-name="galEmployees"] [data-row-index="0"]')

// Label named "lblStatus"
page.locator('[data-control-name="lblStatus"]')
```

### Using the Power Apps Test Engine YAML Format
The Test Engine also supports a declarative YAML format:

```yaml
# testplan.fx.yaml
testSuite:
  testSuiteName: Time Off Approvals
  testSuiteDescription: Validates manager approval workflow
  persona: Manager
  appLogicalName: new_timeoffapp_12345

testCases:
  - testCaseName: Approve a pending request
    testSteps: |
      = Screenshot("before-approval");
      = Select(btnApprovals);
      = Select(First(galRequests));
      = Select(btnApprove);
      = Assert(lblSuccess.Text = "Approved!", "Success label should show");
```

---

## 7. Common Patterns & Recipes

### Wait for Data to Load
```typescript
// Gallery loads async — wait for items to appear
await page.waitForFunction(() => {
  const gallery = document.querySelector('[data-control-name="galItems"]');
  return gallery && gallery.querySelectorAll('[data-row-index]').length > 0;
});
```

### Fill a Form and Submit
```typescript
await page.fill('[data-control-name="txtName"] input', 'Jane Smith');
await page.selectOption('[data-control-name="drpDept"] select', 'Engineering');
await page.click('[data-control-name="btnSubmit"]');
await expect(page.locator('[data-control-name="lblConfirmation"]')).toBeVisible();
```

### Test Across Roles (Personas)
```typescript
test.describe('Admin view', () => {
  test.use({ storageState: 'auth-admin.json' });
  test('sees delete button', async ({ page }) => { ... });
});

test.describe('Viewer role', () => {
  test.use({ storageState: 'auth-viewer.json' });
  test('does not see delete button', async ({ page }) => {
    await expect(page.locator('[data-control-name="btnDelete"]')).toBeHidden();
  });
});
```

### Run Tests in CI (GitHub Actions)
```yaml
# .github/workflows/powerapp-tests.yml
name: Power Apps Playwright Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 18 }
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npx playwright test
        env:
          POWERAPP_URL: ${{ secrets.POWERAPP_URL }}
      - uses: actions/upload-artifact@v4
        if: failure()
        with:
          name: playwright-report
          path: playwright-report/
```

---

## 8. Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| `data-control-name` not found | Control name mismatch | Check exact name in Power Apps Studio properties panel |
| Auth token expired | `storageState` stale | Re-run `playwright codegen --save-storage=auth.json` |
| Gallery has no rows | Data source not loaded | Add `waitForFunction` to wait for gallery items |
| Test flaky on CI | Timing / headless rendering | Increase `timeout`, add explicit waits, use `waitForSelector` |
| App URL changes per publish | App ID in URL updates on republish | Use a stable environment URL or custom connector URL |

---

## Resources

- [Power Apps Test Engine (GitHub)](https://github.com/microsoft/PowerApps-TestEngine)
- [Playwright Docs](https://playwright.dev)
- [Power Fx Reference](https://docs.microsoft.com/power-platform/power-fx/overview)
- [Power Apps Developer Plan](https://aka.ms/powerappsdev)
- [pac CLI Reference](https://docs.microsoft.com/power-platform/developer/cli/reference)
