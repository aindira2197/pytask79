class DiffTool:
    def __init__(self, file1, file2):
        self.file1 = file1
        self.file2 = file2

    def read_files(self):
        with open(self.file1, 'r') as f1, open(self.file2, 'r') as f2:
            content1 = f1.readlines()
            content2 = f2.readlines()
            return content1, content2

    def diff(self):
        content1, content2 = self.read_files()
        diff = []
        for i in range(max(len(content1), len(content2))):
            if i >= len(content1):
                diff.append(f"+ {content2[i].strip()}")
            elif i >= len(content2):
                diff.append(f"- {content1[i].strip()}")
            elif content1[i] != content2[i]:
                diff.append(f"- {content1[i].strip()}")
                diff.append(f"+ {content2[i].strip()}")
            else:
                diff.append(f"  {content1[i].strip()}")
        return diff

    def print_diff(self):
        diff = self.diff()
        for line in diff:
            print(line)

def main():
    file1 = "file1.txt"
    file2 = "file2.txt"
    diff_tool = DiffTool(file1, file2)
    diff_tool.print_diff()

if __name__ == "__main__":
    main()

class ManualDiffTool:
    def __init__(self, content1, content2):
        self.content1 = content1
        self.content2 = content2

    def diff(self):
        diff = []
        for i in range(max(len(self.content1), len(self.content2))):
            if i >= len(self.content1):
                diff.append(f"+ {self.content2[i].strip()}")
            elif i >= len(self.content2):
                diff.append(f"- {self.content1[i].strip()}")
            elif self.content1[i] != self.content2[i]:
                diff.append(f"- {self.content1[i].strip()}")
                diff.append(f"+ {self.content2[i].strip()}")
            else:
                diff.append(f"  {self.content1[i].strip()}")
        return diff

    def print_diff(self):
        diff = self.diff()
        for line in diff:
            print(line)

def manual_diff():
    content1 = ["line1", "line2", "line3"]
    content2 = ["line1", "line4", "line3"]
    manual_diff_tool = ManualDiffTool(content1, content2)
    manual_diff_tool.print_diff()

if __name__ == "__main__":
    manual_diff()