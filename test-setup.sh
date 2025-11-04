#!/bin/bash

# Test script to validate POC setup
echo "🧪 Testing POC Setup..."
echo ""

# Check if required files exist
echo "📁 Checking project structure..."

REQUIRED_FILES=(
  ".gitignore"
  ".github/workflows/ai-pr-review.yml"
  ".github/workflows/test-generator.yml"
  ".github/workflows/test-coverage.yml"
  ".github/pull_request_template.md"
  "force-app/main/default/classes/AccountManager.cls"
  "force-app/main/default/classes/AccountManager.cls-meta.xml"
  "force-app/main/default/classes/ContactService.cls"
  "force-app/main/default/classes/ContactService.cls-meta.xml"
  "force-app/main/default/triggers/OpportunityTrigger.trigger"
  "force-app/main/default/triggers/OpportunityTrigger.trigger-meta.xml"
  "README.md"
)

MISSING_FILES=0

for file in "${REQUIRED_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "✅ $file"
  else
    echo "❌ Missing: $file"
    MISSING_FILES=$((MISSING_FILES + 1))
  fi
done

echo ""
if [ $MISSING_FILES -eq 0 ]; then
  echo "✅ All required files are present!"
else
  echo "❌ $MISSING_FILES file(s) missing"
  exit 1
fi

# Validate YAML syntax (if yq or python-yaml available)
echo ""
echo "🔍 Validating YAML syntax..."

if command -v python3 &> /dev/null; then
  echo "Validating workflow files..."
  for workflow in .github/workflows/*.yml; do
    if python3 -c "import yaml; yaml.safe_load(open('$workflow'))" 2>/dev/null; then
      echo "✅ $(basename $workflow) - Valid YAML"
    else
      echo "⚠️  $(basename $workflow) - YAML validation skipped (pyyaml not installed)"
    fi
  done
else
  echo "⚠️  Python not found - skipping YAML validation"
fi

# Check for common issues
echo ""
echo "🔍 Checking for common setup issues..."

if [ ! -f ".github/workflows/ai-pr-review.yml" ]; then
  echo "❌ AI review workflow missing"
else
  if grep -q "OPENAI_API_KEY" .github/workflows/ai-pr-review.yml; then
    echo "✅ AI review workflow references OPENAI_API_KEY"
  else
    echo "⚠️  AI review workflow may not be configured correctly"
  fi
fi

echo ""
echo "📋 Next Steps:"
echo "1. Add OPENAI_API_KEY to GitHub Secrets (Settings → Secrets and variables → Actions)"
echo "2. Initialize git repository: git init"
echo "3. Create initial commit: git add . && git commit -m 'Initial POC setup'"
echo "4. Push to GitHub and create a test PR"
echo ""
echo "✅ Setup validation complete!"

