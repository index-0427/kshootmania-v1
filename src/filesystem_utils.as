#module filesystem_utils

//
// �t�@�C�������݂��邩��bool�ŕԂ�
// (strsize���w�肳�ꂽ�t�@�C���̃t�@�C���T�C�Y�ŏ㏑�������̂Œ���)
//
//   p1: �t�@�C���p�X�̕�����
//
#defcfunc fileExists str p1
	exist p1
	return strsize != -1

//
// �f�B���N�g���p�X�����݂��邩��bool�ŕԂ�
// (���C���h�J�[�h�̑��݂͌������Ȃ��̂ŁA���������"*"���܂߂Ȃ�����)
//
//   p1: �f�B���N�g���p�X�̕�����
//
#defcfunc dirExists str p1, local path, local fileListStr
	path = p1

	// ������'\'��'/'����菜��
	path = strtrim(path, 2/*�E�[�̂�*/, '/')
	path = strtrim(path, 2/*�E�[�̂�*/, '\\')

	// ���݂��`�F�b�N
	dirlist fileListStr, path, 5/*�f�B���N�g���̂�*/

	return fileListStr != ""

//
// ���݃`�F�b�N�t��chdir
// (�����G���[12�����O�Ƀp�X���̏����_�C�A���O�\�����鑽���}�V��ver)
//
//   p1: �f�B���N�g���p�X�̕�����
//
#deffunc safeChdir str p1
	if (dirExists(p1) = 0) {
		dialog "�G���[: ���L�f�B���N�g�����J���܂���ł����B�t�H���_���ɓ��ꕶ�����܂܂�Ă��Ȃ������m�F���������B\nError: Failed to open the following directory. Make sure the folder name does not contain special characters.\n\n" + p1
	}
	chdir p1
	return

//
// ���݃`�F�b�N�t��chdir[�֐���] (chdir�Ɏ��s�������ǂ�����bool�ŕԂ�)
//
//   p1: �f�B���N�g���p�X�̕�����
//   p2: �f�B���N�g�������݂��Ȃ������ꍇ�Ɋ֐����Ōx���_�C�A���O��\�������邩�ǂ���(bool, �f�t�H���g:true)
//
#defcfunc local safeChdirC_ str p1, int p2
	if (dirExists(p1)) {
		// ����
		chdir p1
		return 1
	} else {
		// ���s
		if (p2) : dialog "�x��: ���L�f�B���N�g�����J���܂���ł����B�t�H���_���ɓ��ꕶ�����܂܂�Ă��Ȃ������m�F���������B\nWarning: Failed to open the following directory. Make sure the folder name does not contain special characters.\n\n" + p1
		return 0
	}

// ���݃`�F�b�N�t��chdir[�֐���]�̃f�t�H���g������`
#define global ctype safeChdirC(%1, %2 = 1)  safeChdirC_@filesystem_utils(%1, %2)

#global

// �}�N������`����Ă���ꍇ��chdir��safeChdir�ɒu��
#ifdef FS_UTILS_REPLACE_CHDIR_WITH_SAFE_CHDIR
#undef chdir
#define global chdir(%1) safeChdir %1
#endif