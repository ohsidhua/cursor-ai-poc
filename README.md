# 🧪 Salesforce DevOps POC: AI-Powered PR Workflows

A **production-ready** POC that reduces PR pain points for **DevOps**, **Developers**, and **QA teams** using AI-powered automation.

## 🚀 Quick Start

### Prerequisites
- GitHub account with repository
- OpenAI API key ([Get one here](https://platform.openai.com/api-keys))

### Setup (5 minutes)

1. **Add GitHub Secret:**
   - Go to your repository → Settings → Secrets and variables → Actions
   - Add secret: `OPENAI_API_KEY` with your OpenAI API key

2. **Files are already in place:**
   - ✅ `.github/workflows/ai-pr-review.yml` - AI code review
   - ✅ `.github/workflows/test-generator.yml` - Auto test generation
   - ✅ `.github/workflows/test-coverage.yml` - Coverage reporting
   - ✅ `.github/pull_request_template.md` - PR template

3. **Test it:**
   - Create a PR with any Apex code changes
   - Watch the AI review appear automatically!

## 📋 What This Does

### For Developers 👨‍💻
- ✅ **Instant AI code review** on every PR
- ✅ **Auto-generated test classes** with one label click
- ✅ **Early detection** of governor limit issues
- ✅ **Security vulnerability scanning**

### For DevOps 🔧
- ✅ **Automated PR reviews** - no manual coordination
- ✅ **Pre-commit quality checks**
- ✅ **Test coverage reporting**
- ✅ **Standardized review process**

### For QA 🧪
- ✅ **Test coverage reports** in every PR
- ✅ **Auto-generated test classes**
- ✅ **Edge case detection**
- ✅ **Code change summaries**

## 🎯 How It Works

1. **Developer creates PR** → AI review workflow triggers automatically
2. **AI analyzes code** → Posts detailed review comment
3. **Need tests?** → Add `generate-tests` label → Tests auto-generated
4. **QA reviews** → Coverage report shows in PR comments

## 📖 Documentation

See [cursor-sf-testable-code.md](./cursor-sf-testable-code.md) for:
- Complete setup guide
- Workflow details
- Troubleshooting
- ROI calculations
- Demo scenarios

## 🛠️ Troubleshooting

**Workflow not running?**
- Check that `OPENAI_API_KEY` secret is set
- Verify file paths match workflow triggers
- Check Actions tab for error logs

**AI review not appearing?**
- Verify API key has credits
- Check workflow logs in Actions tab
- Ensure PR contains `.cls` or `.trigger` files

## 📝 License

MIT License - feel free to use and modify for your organization.

---

**Built with ❤️ for DevOps teams who want to move faster and ship better code.**

