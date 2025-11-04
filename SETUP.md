# 🚀 Setup Instructions

## Quick Setup (5 Minutes)

### Step 1: Add GitHub Secret
1. Go to your GitHub repository
2. Navigate to: **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `OPENAI_API_KEY`
5. Value: Your OpenAI API key ([Get one here](https://platform.openai.com/api-keys))
6. Click **Add secret**

### Step 2: Initialize Git (if not already done)
```bash
git init
git add .
git commit -m "Initial POC setup"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

### Step 3: Test It
1. Create a new branch: `git checkout -b test/ai-review`
2. Make a small change to any Apex file
3. Commit and push: `git push -u origin test/ai-review`
4. Create a Pull Request on GitHub
5. Watch the AI review appear automatically!

## What Gets Triggered

### Automatic Workflows
- **AI Code Review** - Triggers on PR open/update with Apex/Trigger/JS files
- **Test Coverage Report** - Triggers on PR open/update with Apex classes

### Manual Workflows
- **Test Generator** - Add label `generate-tests` to PR, or use workflow_dispatch

## Testing the Workflows

### Test 1: AI Code Review
1. Create PR with `AccountManager.cls` (has intentional issues)
2. AI should detect:
   - SOQL in loops
   - DML in loops
   - Hardcoded API key
   - Missing error handling

### Test 2: Test Generation
1. Create PR with a class that has no test
2. Add label `generate-tests`
3. Workflow will generate test class automatically

### Test 3: Coverage Report
1. Create PR with any Apex classes
2. Coverage report shows which classes have tests

## Troubleshooting

### Workflow Not Running
- Check GitHub Actions tab for errors
- Verify `OPENAI_API_KEY` secret is set correctly
- Ensure file paths match workflow triggers

### AI Review Not Appearing
- Check OpenAI API key has credits
- Review workflow logs in Actions tab
- Verify PR contains `.cls` or `.trigger` files

### Test Generation Failing
- Verify label is exactly `generate-tests` (lowercase, hyphen)
- Check API key has sufficient credits
- Review workflow logs for specific errors

## Cost Estimation

**OpenAI API Costs:**
- GPT-4: ~$0.03 per 1K input tokens, ~$0.06 per 1K output tokens
- Average PR review: ~$0.10-$0.50 per PR
- Test generation: ~$0.20-$1.00 per test class

**To Reduce Costs:**
- Use GPT-3.5-turbo instead (change `gpt-4` to `gpt-3.5-turbo` in workflows)
- Limit review to critical files only
- Use workflow_dispatch for manual triggers

## Next Steps

1. ✅ Setup complete - workflows are ready
2. Create your first PR to test
3. Review AI feedback
4. Customize workflows as needed
5. Train your team on the new process

---

**Need help?** Check [cursor-sf-testable-code.md](./cursor-sf-testable-code.md) for detailed documentation.

