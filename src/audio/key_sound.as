#include "third_party/alib_hash.as"
#include "src/ksmcore.as"

#module key_sound

#define ctype s_keySoundLibrary(%1) HashElem(s_keySoundLibrary, %1)

//
// key_sound���W���[����������
//
//   p1: ���s�t�@�C��������f�B���N�g���̃p�X(dir_default)
//
#deffunc initKeySoundModule str p1
	s_dirDefault = p1

	// �L�[�����i�[���Ă������C�u����
	// (�L�[���̖��O��KeySound�ւ̃|�C���^��Ή��t���鎫��: dict<str, KeySound*>)
	HashInitInt s_keySoundLibrary
	HashClear s_keySoundLibrary
	return

//
// �L�[���̖��O���特���t�@�C���̃p�X���擾
// (�g���q���Ȃ��ꍇ�ɂ�"se\note"�f�B���N�g�����̃t�@�C�����g�p)
//
//   p1: �L�[���̖��O(��:"clap")
//   p2: ���ʃt�@�C���̃f�B���N�g����΃p�X(������\�͕s�v)
//
#defcfunc getFilePathByKeySoundName str p1, str p2, local name
	if(getpath(p1, 2) = ""){
		return s_dirDefault + "\\se\\note\\" + p1 + ".wav"
	} else {
		return p2 + p1
	}

//
// �w��o�[�W�����ɂ�����L�[���̍ő哯�����������擾
//
//   p1: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#defcfunc local getMaxPolyphonyForVersion int p1
	if (p1 >= 171) {
		return 1
	} else {
		return 10
	}

//
// �L�[�������C�u�����ɓǂݍ���
// (�����L�[�������ɓǂݍ��܂�Ă���ꍇ�͉������Ȃ�)
//
//   p1: �L�[���̖��O(��:"clap")
//   p2: ���ʃt�@�C���̃f�B���N�g����΃p�X(������\�͕s�v)
//   p3: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#deffunc loadKeySoundToLibrary str p1, str p2, int p3, local soundFilePath, local pKeySound
	// �܂��ǂݍ��񂾂��Ƃ��Ȃ����ʉ��̏ꍇ�͓ǂݍ���
	if (HashCheckKey(s_keySoundLibrary, p1) = 0) {
		// �����t�@�C���̃p�X���擾���đ��݃`�F�b�N
		soundFilePath = getFilePathByKeySoundName(p1, p2)
		exist soundFilePath
		if(strsize <= 0){
			dialog "Error: Cannot open sound \"" + soundFilePath + "\""
		}

		// KeySound�̎��̂𐶐�
		pKeySound = 0
		if (CreateKeySound@(soundFilePath, getMaxPolyphonyForVersion(p3), varptr(pKeySound))) {
			s_keySoundLibrary(p1) = pKeySound
		} else {
			dialog "Error: An error occurred while loading sound \"" + p1 + "\""
			s_keySoundLibrary(p1) = 0
		}
	}
	return

//
// �L�[�������C�u�����ɑ��݂��邩�𒲂ׂ�
//
//   p1: �L�[���̖��O(��:"clap")
//
#defcfunc keySoundExistsInLibrary str p1
	return HashCheckKey(s_keySoundLibrary, p1)

//
// �L�[���̖��O�����ƂɃ��C�u��������KeySound�ւ̃|�C���^���擾
//
//   p1: �L�[���̖��O(��:"clap")
//
#defcfunc getKeySoundFromLibrary str p1
	if (HashCheckKey(s_keySoundLibrary, p1) = 0) {
		// ���C�u�����ɑ��݂��Ȃ��ꍇ��NULL��Ԃ�
		dialog "Error: Unknown keysound \"" + p1 + "\" is referenced by getKeySoundFromLibrary@key_sound"
		return 0
	}
	return s_keySoundLibrary(p1)

//
// ���C�u�����̃L�[�����N���A
//
#deffunc clearKeySoundLibrary onexit
	foreach s_keySoundLibrary_keys
  		if (s_keySoundLibrary_keys(cnt) = "") : continue
  		if (s_keySoundLibrary_values.cnt = 0) : continue
		DestroyKeySound@ s_keySoundLibrary_values.cnt
	loop
	HashClear s_keySoundLibrary
	return

#global